//
//  DestinationsCollectionViewCell.swift
//  ShowMe
//
//  Created by SayajinPapuru on 25/06/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit

class DestinationsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageDisplayed: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundColorView: UIView!
    
    var destination: Destination? {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        if let destination = destination {
            imageDisplayed.image = destination.destinationsImage
            titleLabel.text = destination.destinationsTitle
            backgroundColorView.backgroundColor = destination.color
        } else {
            imageDisplayed.image = nil
            titleLabel.text = nil
            backgroundColorView.backgroundColor = nil
        }
        
        imageDisplayed.layer.cornerRadius = 10.0
        imageDisplayed.layer.masksToBounds = true
        backgroundColorView.layer.cornerRadius = 10.0
        backgroundColorView.layer.masksToBounds = true
    }
}
