//
//  PlacesInfoView.swift
//  ShowMe
//
//  Created by SayajinPapuru on 14/07/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit

class PlacesInfoView: UITableViewCell {
    
    @IBOutlet weak var placesName: UILabel!
    @IBOutlet weak var placesAddress: UILabel!
    @IBOutlet weak var placesImage: UIImageView!
    @IBOutlet weak var placesRate: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    var googlePlace: GooglePlace?
    var coreDataManager: CoreDataManager?
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
    
    @IBAction func favButtonTapped(_ sender: UIButton) {
        guard let coreDataManager = coreDataManager else { return }
              if coreDataManager.isPlaceRegistered(with: googlePlace?.name ?? "") {
                  coreDataManager.deletePlace(named: googlePlace?.name ?? "")
                favButton.tintColor = .lightGray
              } else {
                  savePlace()
                favButton.tintColor = .purple
              }
    }

        func savePlace() {
        coreDataManager?.createPlace(name: googlePlace?.name ?? "", address: googlePlace?.address ?? "", rating: googlePlace?.rating ?? 0.0)
    }

        func checkFav() {
        guard let coreDataManager = coreDataManager else { return }
        if coreDataManager.isPlaceRegistered(with: googlePlace?.name ?? "" ) {
            favButton.tintColor = .purple
        } else {
            favButton.tintColor = .lightGray
        }
    }
    
    
}
