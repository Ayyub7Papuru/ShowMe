//
//  FavouritesViewController.swift
//  ShowMe
//
//  Created by SayajinPapuru on 21/08/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit
import GoogleMaps
import Contacts
import MapKit

class FavouritesViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var favouritesTableView: UITableView!
    
    // MARK: - Private Properties
    
    private var placesDerails: GooglePlace?
    private let coreDataManager = CoreDataManager(coreDataStack: CoreDataStack())
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setBackground()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favouritesTableView.reloadData()
    }
    
    // MARK: - Private Methods
    
    private func setTableView() {
        favouritesTableView.register(UINib(nibName: "PlacesInfoViewTableViewCell", bundle: nil), forCellReuseIdentifier: "placesFavCell")
    }
    
    private func setBackground() {
        view.backgroundColor = UIColor(named: "background")
        favouritesTableView.backgroundColor = UIColor(named: "background")
    }
    
    private func selectCell(marker: FavouritePlace) {
        let alert = UIAlertController(title: "Select Actions", message: "", preferredStyle: .actionSheet)
        let gps = UIAlertAction(title: "GPS", style: .default) { (_) in
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            let mapItem = PlaceMarker(place: createGooglePlace(favoritePlace: marker)).createMapItem(adress: marker.address ?? "")
            mapItem.openInMaps(launchOptions: launchOptions)
        }
        let remove = UIAlertAction(title: "Remove", style: .default) { (_) in
            self.coreDataManager.deletePlace(named: marker.name ?? "")
            self.favouritesTableView.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(gps)
        alert.addAction(remove)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func clearAllFavorites(_ sender: UIBarButtonItem) {
        coreDataManager.deleteAllPlaces()
        favouritesTableView.reloadData()
    }
}

// MARK: - table View

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager.placesFav.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favouritesTableView.dequeueReusableCell(withIdentifier: "placesFavCell", for: indexPath) as! PlacesInfoViewTableViewCell
        cell.favouritePlace = coreDataManager.placesFav[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectCell(marker: coreDataManager.placesFav[indexPath.row])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return favouritesTableView.frame.height / 3
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Add some places"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = UIColor(named: "titles")
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return coreDataManager.placesFav.isEmpty ? 200:0
    }
}
