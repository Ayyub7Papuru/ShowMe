//
//  SettingsViewController.swift
//  ShowMe
//
//  Created by SayajinPapuru on 11/10/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit
import CoreLocation

class DiscoveryViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var discoveriesCollectionView: UICollectionView!
    
    // MARK: - Private Properties
    private let discoveries = Discovery.fetchDiscoveries()
    private let locationManager = CLLocationManager()
    private lazy var googleService: GoogleService = {
        return GoogleService()
    }()
    private var currentLocation: CLLocationCoordinate2D?

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        setCollectionView()
        setLocation()
    }

    // MARK: - Private Methods
    
    private func setBackground() {
        view.backgroundColor = UIColor(named: "background")
        discoveriesCollectionView?.backgroundColor = UIColor(named: "background")
    }
    
    private func setCollectionView() {
        discoveriesCollectionView?.dataSource = self
        discoveriesCollectionView?.delegate = self
    }
    
    private func setLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
}

extension DiscoveryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return discoveries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = discoveriesCollectionView?.dequeueReusableCell(withReuseIdentifier: "discoveryFlowCell", for: indexPath) as! DiscoveryCollectionViewCell
        let discovery = discoveries[indexPath.item]
        cell.discovery = discovery
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        discoveriesCollectionView.deselectItem(at: indexPath, animated: true)
        let discoveryObject = discoveries[indexPath.row]
        setLocation(discoveryObject: discoveryObject)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "discoveryFlowCellSegue" {
            guard let discoveryTableView = segue.destination as? DiscoveryTableViewController else { return }
            discoveryTableView.myPlaces = sender as? [GooglePlace] ?? [GooglePlace]()
        }
    }
    
    func setLocation(discoveryObject: Discovery) {
        locationManager.requestLocation()
        locationManager.stopUpdatingLocation()
        let latitude = locationManager.location?.coordinate.latitude ?? 37.787994
        let longitude = locationManager.location?.coordinate.longitude ?? -122.407437
        let defaultValue = CLLocationCoordinate2D(latitude: CLLocationDegrees(CGFloat(latitude)), longitude: CLLocationDegrees(CGFloat(longitude)))
        
        googleService.fetchPlacesNearCoordinate(currentLocation ?? defaultValue, radius: 5000, types: [discoveryObject.discoveryObject.key]) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let place):
                    self.performSegue(withIdentifier: "discoveryFlowCellSegue", sender: place.results)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}

extension DiscoveryViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else { return }
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.first?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
