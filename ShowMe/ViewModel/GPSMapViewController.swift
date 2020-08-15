//
//  GPSMapViewController.swift
//  ShowMe
//
//  Created by SayajinPapuru on 14/08/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit
import MapKit

class GPSMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var destinationsLatitude: CLLocationDegrees = 23.348444
    var destinationsLongitude: CLLocationDegrees = 2.4455433
    var destinationsName: String = ""
    var destinationsAddress: String = ""
    
    
    fileprivate let locationManager: CLLocationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        // Check for Location Services
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }

        //Zoom to user location
        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 200, longitudinalMeters: 200)
            mapView.setRegion(viewRegion, animated: false)
        }

        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
        
        mapView.delegate = self
        //Get the current location
        
        view.backgroundColor = .lightGray
        let myPosition = Place(name: "Me", address: "France", coordinate: CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0, longitude: locationManager.location?.coordinate.longitude ?? 0))
        let destination = Place(name: destinationsName, address: destinationsAddress, coordinate: CLLocationCoordinate2D(latitude: destinationsLatitude, longitude: destinationsLongitude))
        mapView.addAnnotation(myPosition)
        mapView.addAnnotation(destination)
    }
}

extension GPSMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Place else { return nil }
        
        let identifier = "place"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView { dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.centerOffset = CGPoint(x: -5, y: 5)
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 48, height: 48)))
            mapsButton.setBackgroundImage(UIImage(named: "maps"), for: .normal)
            view.rightCalloutAccessoryView = mapsButton
        }
        
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let place = view.annotation as? Place else { return }
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        place.mapItem?.openInMaps(launchOptions: launchOptions)
    }
}
