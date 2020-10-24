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

    @IBOutlet weak var discoveryTableView: UITableView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerImage: UIImageView!
    
    // MARK: - Private Properties

    // Variable de stockage des destination
    private var discoveryPlaces: [GooglePlace] = []
    private var service = GoogleService()
    private var place: GooglePlace?
    private let possiblePlacesDictionnary = ["bar", "grocery_or_supermarket", "restaurant", "atm", "embassy", "gas_station", "hotel", "museum", "park", "parking", "tourist_attraction"]

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        setDetails()
        getDiscoveryPlace(CLLocationCoordinate2D(latitude: 48.866667, longitude: 2.333333))
    }

    // MARK: - Private Methods

    private func setBackground() {
        view.backgroundColor = UIColor(named: "background")
    }
    
    private func setDetails() {
        timerImage.layer.cornerRadius = 17
        timerLabel.layer.cornerRadius = 15
        timerLabel.layer.masksToBounds = true
    }
    
    private func getDiscoveryPlace(_ coordinate: CLLocationCoordinate2D) {
        service.fetchPlacesNearCoordinate(coordinate, radius: 5000, types: possiblePlacesDictionnary) { (result) in
            switch result {
            case .success(let place):
                self.discoveryPlaces.append(contentsOf: place.results)
                print(self.discoveryPlaces)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension DiscoveryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Afficher les resulats récupéré par l'appel réseau dans le tableau
        discoveryPlaces.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = discoveryTableView.dequeueReusableCell(withIdentifier: "discoveryCell", for: indexPath) as! DiscoveryTableViewCell
        cell.place = discoveryPlaces[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return discoveryTableView.frame.height / 3
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "No discoveries yet"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = UIColor(named: "titles")
        return label
    }
}
