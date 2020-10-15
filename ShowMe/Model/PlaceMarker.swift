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

class PlaceMarker: GMSMarker {
    
    let place: GooglePlace
    private let availableTypes: [String]
    
    init(place: GooglePlace, availableTypes: [String] = [""]) {
        self.place = place
        self.availableTypes = availableTypes
        super.init()
        
        setPlaceMarker()
    }
    
    var mapItem: MKMapItem? {
        let addressDict = [CNPostalAddressStreetKey: place.vicinity]
        let placemark = MKPlacemark(coordinate: setPlaceCoordinate(), addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = place.name
        return mapItem
    }
    
    func createMapItem(adress: String) -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: adress]
        let placemark = MKPlacemark(coordinate: setPlaceCoordinate(), addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = place.name
        return mapItem
    }
    
    private func setPlaceMarker() {
        position.latitude = place.geometry.location.lat
        position.longitude = place.geometry.location.lng
        
        let places = place.types.filter { availableTypes.contains($0) }
        _ = places.map { icon = imageWithImage(image: UIImage(named: "\($0)_pin") ?? UIImage(), scaledToSize: CGSize(width: 30.0, height: 30.0)) }
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = .pop
    }
    
    private func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    private func setPlaceCoordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: place.geometry.location.lat, longitude: place.geometry.location.lng)
    }
}
