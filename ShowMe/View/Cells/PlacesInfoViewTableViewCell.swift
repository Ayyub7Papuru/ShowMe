//
//  PlacesInfoViewTableViewCell.swift
//  ShowMe
//
//  Created by SayajinPapuru on 24/08/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit

class PlacesInfoViewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var placesName: UILabel!
    @IBOutlet weak var placesAddress: UILabel!
    @IBOutlet weak var placesImage: UIImageView!
    @IBOutlet weak var placesRate: UILabel!
    
    var place: GooglePlace? {
        didSet {
            placesName.text = place?.name
            placesAddress.text = place?.address
            placesImage.image = place?.photo
            placesRate.text = place?.rating.description
        }
    }
    
    var favouritePlace: FavouritePlace? {
        didSet {
            placesName.text = favouritePlace?.name
            placesAddress.text = favouritePlace?.address
            placesRate.text = favouritePlace?.rating.description
            if let data = favouritePlace?.image {
                placesImage.image = UIImage(data: data)
            } else {
                placesImage.image = UIImage(named: "cocktail")
            }
        }
    }
    
}
