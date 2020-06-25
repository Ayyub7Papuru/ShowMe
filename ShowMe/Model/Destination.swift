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
            [Destination(title: "Restaurant", image: UIImage(named: "restaurant")!, color: UIColor(red: 63/255.0, green: 71/255.0, blue: 80/255.0, alpha: 0.2)),
            Destination(title: "Cinema", image: UIImage(named: "cinema")!, color: UIColor(red: 240/255.0, green: 133/255.0, blue: 91/255.0, alpha: 0.3)),
            Destination(title: "Museum", image: UIImage(named: "museum")!, color: UIColor(red: 105/255.0, green: 80/255.0, blue: 227/255.0, alpha: 0.3)),
            Destination(title: "Hospital", image: UIImage(named: "hospital")!, color: UIColor(red: 77/255.0, green: 95/255.0, blue: 135/255.0, alpha: 0.3)),
            Destination(title: "Grocery", image: UIImage(named: "grocery")!, color: UIColor(red: 63/255.0, green: 71/255.0, blue: 80/255.0, alpha: 0.3)),
            Destination(title: "Police Department", image: UIImage(named: "policeDept")!, color: UIColor(red: 240/255.0, green: 133/255.0, blue: 91/255.0, alpha: 0.3)),
            Destination(title: "Airport", image: UIImage(named: "airport")!, color: UIColor(red: 240/255.0, green: 133/255.0, blue: 91/255.0, alpha: 0.2)),
            Destination(title: "Hotel", image: UIImage(named: "hotel")!, color: UIColor(red: 240/255.0, green: 133/255.0, blue: 91/255.0, alpha: 0.3)),
            Destination(title: "Pharmacy", image: UIImage(named: "pharmacy")!, color: UIColor(red: 245/255.0, green: 195/255.0, blue: 139/255.0, alpha: 0.3)),
            Destination(title: "Subway", image: UIImage(named: "subway")!, color: UIColor(red: 19/255.0, green: 213/255.0, blue: 187/255.0, alpha: 0.3)),]
    }
}
