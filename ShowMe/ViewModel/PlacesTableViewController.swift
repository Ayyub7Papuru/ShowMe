//
//  PlacesTableViewController.swift
//  ShowMe
//
//  Created by SayajinPapuru on 14/07/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit

// MARK: - Protocol
protocol PlacesTableViewControllerDelegate: class {
    func placesController(_ controller: PlacesTableViewController, didSelectPlaces places: [String])
}

// MARK: - Class
class PlacesTableViewController: UITableViewController {
    
    let gg = MapsViewController()
    // MARK: - Properties
    private let possiblePlacesDictionnary = ["bakery": "Bakery", "bar": "Bar", "cafe": "Cafe", "grocery_or_supermarket": "Supermarket", "restaurant": "Restaurant", "aquarium": "Aquarium", "atm": "ATM", "bowling_alley": "Bowling", "cinema": "Cinema", "casino": "Casino", "embassy": "Embassy", "police": "Police Station", "gas_station": "Gas Station", "spa": "Spa", "shopping_mall": "Mall", "hospital": "Hospital", "gym": "Gym", "amusement_park": "Amusement Park", "museum": "Museum", "hotel": "Hotel", "jewelry_store": "Jewelry Store", "shoe_store": "Shoe Store", "train_station": "Train Station", "taxi_stand": "Taxi", "zoo": "Zoo", "tourist_attraction": "Places of interests", "parking": "Parking", "park": "Park", "beauty_salon": "Beauty Salon"]
    
    private var sortedKeys: [String] {
        return possiblePlacesDictionnary.keys.sorted()
    }
    
    weak var delegate: PlacesTableViewControllerDelegate?
    var selectedPlaces: [String] = []
    
    // MARK: - Actions
    @IBAction func donePressed(_sender: AnyObject) {
        delegate?.placesController(self, didSelectPlaces: selectedPlaces)
        dismiss(animated: true)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return possiblePlacesDictionnary.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placesCell", for: indexPath)
        let key = sortedKeys[indexPath.row]
        let type = possiblePlacesDictionnary[key]
        cell.textLabel?.text = type
        cell.imageView?.image = UIImage(named: key)
        cell.accessoryType = selectedPlaces.contains(key) ? .checkmark : .none
        cell.tintColor = .purple
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let key = sortedKeys[indexPath.row]
        if selectedPlaces.contains(key) {
            selectedPlaces = selectedPlaces.filter({$0 != key})
        } else {
            selectedPlaces.append(key)
        }
        tableView.reloadData()
    }
}

