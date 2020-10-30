//
//  DiscoveryCollectionViewCell.swift
//  ShowMe
//
//  Created by SayajinPapuru on 30/10/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit

class DiscoveryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var headTitle: UILabel?
    @IBOutlet weak var mainTitle: UILabel?
    @IBOutlet weak var subTitle: UILabel?
    @IBOutlet weak var discoveryImage: UIImageView?
    
    var discovery: Discovery? {
        didSet {
            self.updateDiscoveries()
        }
    }
    
    func updateDiscoveries() {
        if let discovery = discovery {
            headTitle?.text = discovery.discoveryHeadTitle
            mainTitle?.text = discovery.discoveryMainTitle
            subTitle?.text = discovery.discoverySubTitle
            discoveryImage?.image = discovery.discoveryImage
        } else {
            headTitle?.text = nil
            mainTitle?.text = nil
            subTitle?.text = nil
            discoveryImage?.image = nil
        }
        discoveryImage?.layer.cornerRadius = 10.0
        discoveryImage?.layer.masksToBounds = true
    }
}
