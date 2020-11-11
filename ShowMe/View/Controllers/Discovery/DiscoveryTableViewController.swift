//
//  DiscoveryTableViewController.swift
//  ShowMe
//
//  Created by SayajinPapuru on 08/11/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit
import CoreLocation

class DiscoveryTableViewController: UIViewController {

    @IBOutlet weak var discoveryTableView: UITableView!
    
    var myPlaces = [GooglePlace]()
    let service = GoogleService()
    var zoo = ["zoo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        discoveryTableView.register(UINib(nibName: "DiscoveryTableViewCell", bundle: nil), forCellReuseIdentifier: "discoveryCell")
    }
}

extension DiscoveryTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = discoveryTableView.dequeueReusableCell(withIdentifier: "discoveryCell", for: indexPath) as! DiscoveryTableViewCell
        cell.place = myPlaces[indexPath.row]
        return cell
    }
}
