//
//  PlacesTableViewController.swift
//  ShowMe
//
//  Created by SayajinPapuru on 14/07/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit

// MARK: - Protocol

<<<<<<< HEAD
protocol PlacesTableViewControllerDelegate: AnyObject {
=======
protocol PlacesTableViewControllerDelegate: class {
>>>>>>> 52b71541a1b6083bb190ed920fff5b3055e8e62b
    func placesController(didSelectPlaces places: [String])
}

// MARK: - Class

class PlacesTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    weak var delegate: PlacesTableViewControllerDelegate?
    public let placeTableViewModel = PlacesTableViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
    }
    
    // MARK: - Actions
    
    @IBAction func donePressed(_sender: AnyObject) {
        delegate?.placesController(didSelectPlaces: placeTableViewModel.selectedPlaces)
//        checkPlaces()
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    
    private func setBackground() {
        view.backgroundColor = UIColor(named: "background")
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeTableViewModel.possiblePlacesDictionnary.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 18
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placesCell", for: indexPath)
        let key = placeTableViewModel.sortedKeys[indexPath.row]
        let type = placeTableViewModel.possiblePlacesDictionnary[key]
        cell.textLabel?.text = type
        cell.imageView?.image = UIImage(named: key)
        cell.accessoryType = placeTableViewModel.selectedPlaces.contains(key) ? .checkmark : .none
        cell.tintColor = .purple
        cell.backgroundColor = UIColor(named: "background")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        placeTableViewModel.didSelectPlacesTableView(indexPath: indexPath)
        tableView.reloadData()
    }
}

