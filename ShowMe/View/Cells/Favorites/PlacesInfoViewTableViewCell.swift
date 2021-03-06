//
//  PlacesInfoViewTableViewCell.swift
//  ShowMe
//
//  Created by SayajinPapuru on 24/08/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit

class PlacesInfoViewTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var placesName: UILabel!
    @IBOutlet weak var placesAddress: UILabel!
    @IBOutlet weak var placesImage: UIImageView!
    @IBOutlet weak var placesRate: UILabel!
    
    // MARK: - Properties
    
    var favouritePlace: FavouritePlace? {
        didSet {
            placesName.text = favouritePlace?.name
            placesAddress.text = favouritePlace?.address
            placesRate.text = favouritePlace?.rating.description
            placesImage.image = UIImage(data: favouritePlace?.image ?? Data())
        }
    }
}
