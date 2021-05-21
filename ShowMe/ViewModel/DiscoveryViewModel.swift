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
<<<<<<< HEAD
            Discovery(discoveryObject: .gym),
            Discovery(discoveryObject: .zoo),
            Discovery(discoveryObject: .park),
            Discovery(discoveryObject: .campground),
            Discovery(discoveryObject: .art_gallery),
            Discovery(discoveryObject: .aquarium),
            Discovery(discoveryObject: .casino)
            
        ]
        //aquarium, art_gallery, campground, casino
    }
    
    enum DiscoveryObject {
        case hotels, zoo, park, casino, campground, art_gallery, aquarium, gym
=======
            Discovery(discoveryObject: .zoo),
            Discovery(discoveryObject: .park)
        ]
        //aquarium, art_gallery, campground, casino, night_club, tourist_attraction
    }
    
    enum DiscoveryObject {
        case hotels, zoo, park
>>>>>>> 52b71541a1b6083bb190ed920fff5b3055e8e62b
        
        var title: String {
            switch self {
            case .hotels:
                return "HOTELS"
            case .zoo:
                return "ZOOS"
            case .park:
                return "AMUSEMENT PARK"
<<<<<<< HEAD
            case .casino:
                return "CASINO"
            case .campground:
                return "CAMPGROUND"
            case .art_gallery:
                return "ART GALLERY"
            case .aquarium:
                return "AQUARIUM"
            case .gym:
                return "GYM"
=======
>>>>>>> 52b71541a1b6083bb190ed920fff5b3055e8e62b
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
<<<<<<< HEAD
            case .casino:
                return "casino"
            case .campground:
                return "campground"
            case .art_gallery:
                return "art_gallery"
            case .aquarium:
                return "aquarium"
            case .gym:
                return "gym"
=======
>>>>>>> 52b71541a1b6083bb190ed920fff5b3055e8e62b
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
<<<<<<< HEAD
            case .casino:
                return "CHALLENGE LUCK !"
            case .campground:
                return "NIGHT STARS"
            case .art_gallery:
                return "HEART"
            case .aquarium:
                return "SEA THE BEAUTY"
            case .gym:
                return "ENHANCE YOUR BODY"
=======
>>>>>>> 52b71541a1b6083bb190ed920fff5b3055e8e62b
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
<<<<<<< HEAD
            case .casino:
                return "Play wisely"
            case .campground:
                return "Best camps near you"
            case .art_gallery:
                return "Sharp your art sense"
            case .aquarium:
                return "Beautiful creatures in water but on earth"
            case .gym:
                return "Road to Ninja"
=======
>>>>>>> 52b71541a1b6083bb190ed920fff5b3055e8e62b
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
<<<<<<< HEAD
            case .casino:
                return UIImage(named: "casinoExplore") ?? UIImage()
            case .campground:
                return UIImage(named: "campground") ?? UIImage()
            case .art_gallery:
                return UIImage(named: "art_gallery") ?? UIImage()
            case .aquarium:
                return UIImage(named: "aquariumExplore") ?? UIImage()
            case .gym:
                return UIImage(named: "gymExplore") ?? UIImage()
                
=======
>>>>>>> 52b71541a1b6083bb190ed920fff5b3055e8e62b
            }
        }
    }
}
