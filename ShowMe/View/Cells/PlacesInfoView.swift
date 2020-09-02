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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setXib()
    }
    
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
    
    // MARK: - Private Methods
    private func setXib() {
        let bundle = Bundle.init(for: PlacesInfoView.self)
        if let viewsToAdd = bundle.loadNibNamed("PlacesInfoView", owner: self, options: nil), let contentView = viewsToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
        }
    }
    
    private func setUIView() {
        layer.cornerRadius = 20
    }
}
