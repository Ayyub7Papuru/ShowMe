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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        discoveryTableView.register(UINib(nibName: "DiscoveryTableViewCell", bundle: nil), forCellReuseIdentifier: "discoveryCell")
        ifEmpty()
    }
    
    func ifEmpty() {
        if myPlaces.isEmpty {
            let alert = UIAlertController(title: "NO DESTINATION FOUND", message: "Return to discovery", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { alert in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension DiscoveryTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if myPlaces.isEmpty {
            ifEmpty()
        }
        return myPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = discoveryTableView.dequeueReusableCell(withIdentifier: "discoveryCell", for: indexPath) as! DiscoveryTableViewCell
        cell.place = myPlaces[indexPath.row]
        return cell
    }
}
