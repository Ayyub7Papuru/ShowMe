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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        //Get the current location

        view.backgroundColor = .lightGray
        let destination = Place(name: "Me", address: "France", coordinate: CLLocationCoordinate2D(latitude: 48.8534, longitude: 2.3488))
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
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let place = view.annotation as? Place else { return }
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        place.mapItem?.openInMaps(launchOptions: launchOptions)
    }
}
