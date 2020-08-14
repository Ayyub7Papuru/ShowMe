//
//  PlacesInfoView.swift
//  ShowMe
//
//  Created by SayajinPapuru on 14/07/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit

class PlacesInfoView: UIView {
    
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
    
}
