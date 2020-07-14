//
//  PlaceMarker.swift
//  ShowMe
//
//  Created by SayajinPapuru on 14/07/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import Foundation
import  GoogleMaps

class PlaceMarker: GMSMarker {
    let place: GooglePlace
    
    init(place: GooglePlace, availableTypes: [String]) {
        self.place = place
        super.init()
        
        position = place.coordinate
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = .pop
        
        var foundType = "cinema"
        let possibleTypes = availableTypes.count > 0 ? availableTypes : ["cinema", "bar", "restaurant", "grocery_or_supermarket"]
        for type in place.types {
            if possibleTypes.contains(type) {
                foundType = type
                break
            }
        }
        icon = UIImage(named: foundType+"_pin")
    }
}
