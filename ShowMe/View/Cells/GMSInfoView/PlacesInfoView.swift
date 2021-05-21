//
//  PlacesInfoView.swift
//  ShowMe
//
//  Created by SayajinPapuru on 14/07/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit
import SDWebImage

class PlacesInfoView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var placesName: UILabel!
    @IBOutlet weak var placesAddress: UILabel!
    @IBOutlet weak var placesImage: UIImageView!
    @IBOutlet weak var placesRate: UILabel!
    
    // MARK: - Initialisation
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setXib()
    }
    
    // MARK: - Properties
    
    var mapsVC: MapsViewController?
    var place: GooglePlace? {
        didSet {
            placesName.text = place?.name
            placesAddress.text = place?.vicinity
            placesImage.sd_setImage(with: URL(string: mapsVC?.mapsViewModel.dataProvider.fetchPhoto(reference: place?.photos?.first?.photoReference ?? "") ?? ""), placeholderImage: UIImage())
            placesRate.text = String(describing: place?.rating)
        }
    }
    
    var favouritePlace: FavouritePlace? {
        didSet {
            placesName.text = favouritePlace?.name
            placesAddress.text = favouritePlace?.address
            placesRate.text = String(describing: favouritePlace?.rating)
            if let imageData = favouritePlace?.image {
                placesImage.image = UIImage(data: imageData)
            } else {
                placesImage.image = UIImage(named: "")
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
