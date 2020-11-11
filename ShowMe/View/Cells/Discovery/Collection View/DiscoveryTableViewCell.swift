//
//  DiscoveryTableViewCell.swift
//  ShowMe
//
//  Created by SayajinPapuru on 23/10/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit

class DiscoveryTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var destinationsName: UILabel!
    @IBOutlet weak var destinationsImage: UIImageView!
    @IBOutlet weak var destinationsAddress: UILabel!
    @IBOutlet weak var destinationsRating: UILabel!
    
    // MARK: - Properties
    
    var service = GoogleService()
    var place: GooglePlace? {
        didSet {
            destinationsName.text = place?.name
            destinationsImage.sd_setImage(with: URL(string: service.fetchPhoto(reference: place?.photos?.first?.photoReference ?? "")), placeholderImage: UIImage())
            destinationsAddress.text = place?.vicinity
            destinationsRating.text = place?.rating?.description

        }
    }
}
