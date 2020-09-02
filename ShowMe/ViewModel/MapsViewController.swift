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

class MapsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var mapView: GMSMapView!
    
    // MARK: - Properties
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    var searchedPlaces = ["bar", "grocery_or_supermarket", "restaurant", "atm", "cinema", "embassy", "gas_station", "hospital", "hotel", "museum", "park", "parking", "police", "shopping_mall", "tourist_attraction"]
    
    private var locationManager = CLLocationManager()
    let dataProvider = GoogleService()
    let searchRadius: Double = 10000
    var googlePlace: GooglePlace?
    var coreDataManager: CoreDataManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        autoCompletion()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      guard
        let navigationController = segue.destination as? UINavigationController,
        let controller = navigationController.topViewController as? PlacesTableViewController
        else {
          return
      }
      controller.selectedPlaces = searchedPlaces
      controller.delegate = self
    }
    
    
    
    // MARK: - Functions
    @IBAction func refreshPlaces(_ sender: Any) {
        fetchPlaces(near: mapView.camera.target)
    }
    
    func autoCompletion() {
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
    
    func fetchPlaces(near coordinate: CLLocationCoordinate2D) {
        mapView.clear()
        dataProvider.fetchPlacesNearCoordinate(coordinate, radius: searchRadius, types: searchedPlaces) { places in
            places.forEach { place in
                let marker = PlaceMarker(place: place, availableTypes: self.searchedPlaces, coordinate: coordinate)
                marker.map = self.mapView
            }
        }
    }
    
    func savePlace() {
        coreDataManager?.createPlace(name: googlePlace?.name ?? "", address: googlePlace?.address ?? "", rating: googlePlace?.rating ?? 0.0, longitude: Double(googlePlace?.coordinate.longitude ?? 0), latitude: Double(googlePlace?.coordinate.latitude ?? 0))
    }
    
    private func checkFav() {
        guard let coreDataManager = coreDataManager else { return }
        if coreDataManager.isPlaceRegistered(with: googlePlace?.name ?? "") {
            coreDataManager.deletePlace(named: googlePlace?.name ?? "")
        } else {
            savePlace()
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
        
        print("Place name: \(String(describing: place.name))")
        print("Place address: \(String(describing: place.formattedAddress))")
        print("Place attributions: \(String(describing: place.attributions))")
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
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
        searchedPlaces = places
        fetchPlaces(near: mapView.camera.target)
    }
}

// MARK: - GMSMapViewDelegate
extension MapsViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didLongPressInfoWindowOf marker: GMSMarker) {
        guard let placeMarker = marker as? PlaceMarker else { return }
         UINotificationFeedbackGenerator().notificationOccurred(.success)
         let alert = UIAlertController(title: "Select Actions", message: "", preferredStyle: .actionSheet)
         let gps = UIAlertAction(title: "GPS", style: .default) { (_) in
             let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
             placeMarker.mapItem?.openInMaps(launchOptions: launchOptions)
         }
         let save = UIAlertAction(title: "Save", style: .default) { (_) in
            self.coreDataManager = CoreDataManager(coreDataStack: CoreDataStack())
            self.coreDataManager?.createPlace(name: placeMarker.place.name, address: placeMarker.place.address ?? "", rating: placeMarker.place.rating, longitude: placeMarker.coordinate.longitude, latitude: placeMarker.coordinate.latitude)
            print(self.coreDataManager?.placesFav)
         }
         let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
         alert.addAction(gps)
         alert.addAction(save)
         alert.addAction(cancel)
         
         present(alert, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        guard let placeMarker = marker as? PlaceMarker else { return nil }
            let infoView = PlacesInfoView(frame: CGRect(x: 0, y: 0, width: 300, height: 250))
            infoView.placesName.text = placeMarker.place.name
            infoView.placesAddress.text = placeMarker.place.address
            infoView.placesRate.text = placeMarker.place.rating.description
        
            if let photo = placeMarker.place.photo {
                infoView.placesImage.image = photo
            } else {
                infoView.placesImage.image = UIImage(named: "cocktail")
            }
           
            return infoView
    }
}
