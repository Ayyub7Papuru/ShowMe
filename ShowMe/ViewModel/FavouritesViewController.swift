//
//  FavouritesViewController.swift
//  ShowMe
//
//  Created by SayajinPapuru on 21/08/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController {

    @IBOutlet weak var favouritesTableView: UITableView!
    
    private var coreDataManager: CoreDataManager?
    private var placesDerails: GooglePlace?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
        
        favouritesTableView.register(UINib(nibName: "PlacesInfoView", bundle: nil), forCellReuseIdentifier: "placesCell")

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favouritesTableView.reloadData()
    }
}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coreDataManager?.placesFav.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favouritesTableView.dequeueReusableCell(withIdentifier: "placesCell", for: indexPath) as! PlacesInfoView
        let favouritePlace = coreDataManager?.placesFav[indexPath.row]
        cell.favouritePlace = favouritePlace
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return favouritesTableView.frame.height / 3
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Please add some favorites"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return coreDataManager?.placesFav.isEmpty ?? true ? 200 : 0
    }
}
