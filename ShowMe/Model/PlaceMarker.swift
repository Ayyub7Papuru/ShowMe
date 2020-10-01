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
    let selectedPlace: [String]
    
    init(place: GooglePlace, availableTypes: [String] = [""], coordinate: CLLocationCoordinate2D, selectedPlace: [String] = [""]) {
        self.place = place
        self.coordinate = coordinate
        self.selectedPlace = selectedPlace
        super.init()
        
        position.latitude = place.geometry.location.lat
        position.longitude = place.geometry.location.lng
        
        let places = place.types.filter { selectedPlace.contains($0) }
        _ = places.map { icon = UIImage(named: "\($0)_pin") }
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = .pop
    }
    
    var mapItem: MKMapItem? {
        let addressDict = [CNPostalAddressStreetKey: place.vicinity]
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
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
