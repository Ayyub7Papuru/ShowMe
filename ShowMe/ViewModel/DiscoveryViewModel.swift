//
//  DiscoveryViewModel.swift
//  ShowMe
//
//  Created by SayajinPapuru on 30/10/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit

class Discovery {
    
    // MARK: - Private Properties
    
    let discoveryObject: DiscoveryObject
    
    init(discoveryObject: DiscoveryObject) {
        self.discoveryObject = discoveryObject
    }
    
    static func fetchDiscoveries() -> [Discovery] {
        return [
            Discovery(discoveryObject: .hotels),
            Discovery(discoveryObject: .zoo),
            Discovery(discoveryObject: .park)
        ]
        //aquarium, art_gallery, campground, casino, night_club, tourist_attraction
    }
    
    enum DiscoveryObject {
        case hotels, zoo, park
        
        var title: String {
            switch self {
            case .hotels:
                return "HOTELS"
            case .zoo:
                return "ZOOS"
            case .park:
                return "AMUSEMENT PARK"
            }
        }
        
        var key: String {
            switch self {
            case .hotels:
                return "hotel"
            case .zoo:
                return "zoo"
            case .park:
                return "amusement_park"
            }
        }
        
        var mainTitle: String {
            switch self {
            case .hotels:
                return "FEEL SLEEPY ?"
            case .zoo:
                return "JUNGLE TOUR"
            case .park:
                return "SENSATIONS"
            }
        }
        
        var subtitle: String {
            switch self {
            case .hotels:
                return "The best hotels near you"
            case .zoo:
                return "Explore wildlife near you"
            case .park:
                return "Push your limits"
            }
        }
        
        var discoveryImage: UIImage {
            switch self {
            case .hotels:
                return UIImage(named: "atlantis") ?? UIImage()
            case .zoo:
                return UIImage(named: "hippopotamus") ?? UIImage()
            case .park:
                return UIImage(named: "disney") ?? UIImage()
            }
        }
    }
}
