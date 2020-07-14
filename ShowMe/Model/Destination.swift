//
//  Destination.swift
//  ShowMe
//
//  Created by SayajinPapuru on 25/06/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import Foundation
import UIKit

class Destination {
    
    var destinationsTitle = ""
    var destinationsImage: UIImage
    var color: UIColor
    
    init(title: String, image: UIImage, color: UIColor) {
        self.destinationsTitle = title
        self.destinationsImage = image
        self.color = color
    }
    
    static func fetchDestinations() -> [Destination] {
        return
            [Destination(title: "Restaurant", image: UIImage(named: "restaurantHome")!, color: UIColor(red: 63/255.0, green: 71/255.0, blue: 80/255.0, alpha: 0.2)),
            Destination(title: "Cinema", image: UIImage(named: "cinemaHome")!, color: UIColor(red: 240/255.0, green: 133/255.0, blue: 91/255.0, alpha: 0.3)),
            Destination(title: "Museum", image: UIImage(named: "museumHome")!, color: UIColor(red: 105/255.0, green: 80/255.0, blue: 227/255.0, alpha: 0.3)),
            Destination(title: "Hospital", image: UIImage(named: "hospitalHome")!, color: UIColor(red: 77/255.0, green: 95/255.0, blue: 135/255.0, alpha: 0.3)),
            Destination(title: "Grocery", image: UIImage(named: "groceryHome")!, color: UIColor(red: 63/255.0, green: 71/255.0, blue: 80/255.0, alpha: 0.3)),
            Destination(title: "Police Department", image: UIImage(named: "policeDeptHome")!, color: UIColor(red: 240/255.0, green: 133/255.0, blue: 91/255.0, alpha: 0.3)),
            Destination(title: "Airport", image: UIImage(named: "airportHome")!, color: UIColor(red: 240/255.0, green: 133/255.0, blue: 91/255.0, alpha: 0.2)),
            Destination(title: "Hotel", image: UIImage(named: "hotelHome")!, color: UIColor(red: 240/255.0, green: 133/255.0, blue: 91/255.0, alpha: 0.3)),
            Destination(title: "Pharmacy", image: UIImage(named: "pharmacyHome")!, color: UIColor(red: 245/255.0, green: 195/255.0, blue: 139/255.0, alpha: 0.3)),
            Destination(title: "Subway", image: UIImage(named: "subwayHome")!, color: UIColor(red: 19/255.0, green: 213/255.0, blue: 187/255.0, alpha: 0.3)),]
    }
}
