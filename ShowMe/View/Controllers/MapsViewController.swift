//
//  MapsViewController.swift
//  ShowMe
//
//  Created by SayajinPapuru on 02/07/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
import MapKit
import Contacts
import SDWebImage

class MapsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var mapView: GMSMapView!
    
    // MAR: - Public Properties
    
    public let mapsViewModel = MapsViewModel()
    
    // MARK: - Private Properties
    
    private var resultsViewController: GMSAutocompleteResultsViewController?
    private var searchController: UISearchController?
    private var resultView: UITextView?
    private var locationManager = CLLocationManager()
    private var placeImage: UIImage?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setController()
        setBackground()
        checkDarkMode()
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationController = segue.destination as? UINavigationController,
              let controller = navigationController.topViewController as? PlacesTableViewController else { return }
        controller.placeTableViewModel.selectedPlaces = mapsViewModel.searchedPlaces
        controller.delegate = self
    }
    
    // MARK: - IBActions
    
    @IBAction func refreshPlaces(_ sender: Any) {
        fetchPlaces(near: mapView.camera.target)
    }
    
    @IBAction func mapStyleButtonItem(_ sender: UIBarButtonItem) {
        
        switch mapView.mapType {
        case .normal:
            mapView.mapType = GMSMapViewType.satellite
        case .satellite:
            mapView.mapType = GMSMapViewType.hybrid
        case .hybrid:
            mapView.mapType = GMSMapViewType.terrain
        case .terrain:
            mapView.mapType = GMSMapViewType.none
        case .none:
            mapView.mapType = GMSMapViewType.normal
        
        @unknown default:
            fatalError()
        }
    }
    
    
    
    // MARK: - Private Methods
    
    private func setController() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        autoCompletion()
    }
    
    private func checkDarkMode() {
        if traitCollection.userInterfaceStyle == .dark {
            mapNightMode()
        } else {
            mapView.mapType = GMSMapViewType.normal
        }
    }
    
    private func mapNightMode() {
        do {
          if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
            mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
          } else {
            NSLog("Unable to find style.json")
          }
         } catch {
           NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
    
    private func setBackground() {
        view.backgroundColor = UIColor(named: "background")
    }
    
    private func autoCompletion() {
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        // Put the search bar in the navigation bar.
        searchController?.searchBar.sizeToFit()
        navigationItem.titleView = searchController?.searchBar
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
        
        // Prevent the navigation bar from being hidden when searching.
        searchController?.hidesNavigationBarDuringPresentation = false
    }
    
    private func savePlace() {
        mapsViewModel.coreDataManager?.createPlace(name: mapsViewModel.googlePlace?.name ?? "",
                                                   address: mapsViewModel.googlePlace?.vicinity ?? "",
                                                   image: placeImage?.jpegRepresentationData ?? Data(),
                                                   rating: mapsViewModel.googlePlace?.rating ?? 0.0,
                                                   longitude: Double(mapsViewModel.googlePlace?.geometry.location.lng ?? 0),
                                                   latitude: Double(mapsViewModel.googlePlace?.geometry.location.lat ?? 0))
    }
    
    private func fetchPlaces(near coordinate: CLLocationCoordinate2D) {
        mapView.clear()
        self.mapsViewModel.dataProvider.fetchPlacesNearCoordinate(coordinate, radius: self.mapsViewModel.searchRadius, types: self.mapsViewModel.searchedPlaces) { result in
            switch result {
            case .success(let welcome):
                DispatchQueue.main.async {
                    welcome.results.forEach { place in
                        let marker = PlaceMarker(place: place, availableTypes: self.mapsViewModel.searchedPlaces)
                        marker.map = self.mapView
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - GMSAutocomplete

extension MapsViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        let camera = GMSCameraPosition(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 15.0)
        let update = GMSCameraUpdate.setCamera(camera)
        mapView.moveCamera(update)
        
//        print("Place name: \(String(describing: place.name))")
//        print("Place address: \(String(describing: place.formattedAddress))")
//        print("Place attributions: \(String(describing: place.attributions))")
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
}

// MARK: - CLLocationManagerDelegate

extension MapsViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else { return }
        locationManager.requestLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        fetchPlaces(near: location.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

// MARK: - PlacesTableViewControllerDelegate

extension MapsViewController: PlacesTableViewControllerDelegate {
    func placesController(didSelectPlaces places: [String]) {
        mapsViewModel.searchedPlaces = places
        fetchPlaces(near: mapView.camera.target)
    }
}

// MARK: - GMSMapViewDelegate

extension MapsViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didLongPressInfoWindowOf marker: GMSMarker) {
        guard let placeMarker = marker as? PlaceMarker else { return }
        alertLongPressInfo(placeMarker: placeMarker)
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        guard let placeMarker = marker as? PlaceMarker else { return nil }
        return setMarkerInfo(placeMarker: placeMarker)
    }
    
    private func alertLongPressInfo(placeMarker: PlaceMarker) {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        let alert = UIAlertController(title: "Select Actions", message: "", preferredStyle: .actionSheet)
        let gps = UIAlertAction(title: "GPS", style: .default) { (_) in
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            placeMarker.mapItem?.openInMaps(launchOptions: launchOptions)
        }
        let save = UIAlertAction(title: "Save", style: .default) { (_) in
            self.mapsViewModel.coreDataManager = CoreDataManager(coreDataStack: CoreDataStack())
            self.savePlace()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(gps)
        alert.addAction(save)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func setMarkerInfo(placeMarker: PlaceMarker) -> UIView {
        let infoView = PlacesInfoView(frame: CGRect(x: 0, y: 0, width: 250, height: 200))
        infoView.clipsToBounds = true
        infoView.layer.cornerRadius = 20
        infoView.mapsVC = self
        infoView.placesImage.sd_setImage(with: URL(string: mapsViewModel.dataProvider.fetchPhoto(reference: placeMarker.place.photos?.first?.photoReference ?? "")), placeholderImage: UIImage()) { (image, error, cache, url) in
            infoView.placesImage.image = image
            self.placeImage = image
        }
        
        infoView.placesName.text = placeMarker.place.name
        infoView.placesAddress.text = placeMarker.place.vicinity
        infoView.placesRate.text = String(placeMarker.place.rating ?? 0)
        mapsViewModel.googlePlace = placeMarker.place
        return infoView
    }
}
