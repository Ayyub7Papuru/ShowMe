//
//  FavouritesViewController.swift
//  ShowMe
//
//  Created by SayajinPapuru on 21/08/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var favouritesTableView: UITableView!
    
    // MARK: - Private Properties
    
    private var placesDerails: GooglePlace?
    private let coreDataManager = CoreDataManager(coreDataStack: CoreDataStack())
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favouritesTableView.reloadData()
    }
    
    // MARK: - Private Methods
    
    private func setTableView() {
        favouritesTableView.register(UINib(nibName: "PlacesInfoViewTableViewCell", bundle: nil), forCellReuseIdentifier: "placesFavCell")
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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return favouritesTableView.frame.height / 3
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Add some favorites places"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }
}
