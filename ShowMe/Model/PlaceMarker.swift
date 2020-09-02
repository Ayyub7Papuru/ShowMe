//
//  PlaceMarker.swift
//  ShowMe
//
//  Created by SayajinPapuru on 14/07/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import Foundation
import GoogleMaps
import MapKit
import Contacts

class PlaceMarker: GMSMarker, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    let place: GooglePlace
    
    init(place: GooglePlace = GooglePlace(dictionary: [:], acceptedTypes: [""]), availableTypes: [String] = [""], coordinate: CLLocationCoordinate2D) {
        self.place = place
        self.coordinate = coordinate
        super.init()
        
        position = place.coordinate
        icon = UIImage(named: place.placeType+"_pin")
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = .pop
    }
    
    var mapItem: MKMapItem? {
        guard let location = place.address else { return nil }
        
        let addressDict = [CNPostalAddressStreetKey: location]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = place.name
        return mapItem
    }
    
    func createMapItem(adress: String) -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: adress]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = place.name
        return mapItem
    }
}
