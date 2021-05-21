//
//  PlacesTableViewModel.swift
//  ShowMe
//
//  Created by SayajinPapuru on 08/10/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import Foundation

class PlacesTableViewModel {
    
    // MARK: - Public Properties
    public let possiblePlacesDictionnary = ["bar": "Bar", "grocery_or_supermarket": "Supermarket", "restaurant": "Restaurant", "atm": "ATM", "embassy": "Embassy", "gas_station": "Gas Station", "hotel": "Hotel", "museum": "Museum", "park": "Park", "parking": "Parking", "tourist_attraction": "Places of interests"]
    
    public var sortedKeys: [String] {
        return possiblePlacesDictionnary.keys.sorted()
    }
    
    public var selectedPlaces: [String] = []
    
    // MARK: - Public MEthods
    
    public func didSelectPlacesTableView(indexPath: IndexPath) {
        selectedPlaces.removeAll()
        let key = sortedKeys[indexPath.row]
        if selectedPlaces.contains(key) {
            selectedPlaces = selectedPlaces.filter({$0 != key})
        } else {
            selectedPlaces.append(key)
        }
    }
}
