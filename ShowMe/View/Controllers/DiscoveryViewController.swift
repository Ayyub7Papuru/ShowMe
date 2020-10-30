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
    @IBOutlet weak var discoveriesCollectionView: UICollectionView?
    
    // MARK: - Properties
    var discoveries = Discovery.fetchDiscoveries()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        discoveriesCollectionView?.dataSource = self
        discoveriesCollectionView?.delegate = self
    }
    

    // MARK: - Private Methods
    
    private func setBackground() {
        view.backgroundColor = UIColor(named: "background")
        discoveriesCollectionView?.backgroundColor = UIColor(named: "background")
    }
}

extension DiscoveryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return discoveries.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = discoveriesCollectionView?.dequeueReusableCell(withReuseIdentifier: "discoveryFlowCell", for: indexPath) as! DiscoveryCollectionViewCell
        let discovery = discoveries[indexPath.item]
        cell.discovery = discovery
        return cell
    }
    
}
