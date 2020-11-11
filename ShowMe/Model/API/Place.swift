//
//  Place.swift
//  ShowMe
//
//  Created by SayajinPapuru on 14/08/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class Place: NSObject, MKAnnotation {
    let title: String?
    let address: String?
    let coordinate: CLLocationCoordinate2D
    
    init(name: String, address: String, coordinate: CLLocationCoordinate2D) {
        self.title = name
        self.address = address
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return address
    }
    
    var mapItem: MKMapItem? {
        guard let location = address else { return nil }
        
        let addressDict = [CNPostalAddressStreetKey: location]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}
