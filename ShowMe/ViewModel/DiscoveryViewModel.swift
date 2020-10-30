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
    
    var discoveryHeadTitle = ""
    var discoveryMainTitle = ""
    var discoverySubTitle = ""
    var discoveryImage: UIImage
    
    init(headTitle: String, mainTitle: String, subTitle: String, discoveryImage: UIImage) {
        self.discoveryHeadTitle = headTitle
        self.discoveryMainTitle = mainTitle
        self.discoverySubTitle = subTitle
        self.discoveryImage = discoveryImage
    }
    
    static func fetchDiscoveries() -> [Discovery] {
        return [
            Discovery(headTitle: "HOTELS", mainTitle: "FEEL SLEEPY ?", subTitle: "The best hotels near you", discoveryImage: UIImage(named: "atlantis")!),
            Discovery(headTitle: "ZOOS", mainTitle: "JUNGLE TOUR", subTitle: "Explore the wildlife near you", discoveryImage: UIImage(named: "hippopotamus")!),
            Discovery(headTitle: "AMUSEMENT PARK", mainTitle: "DREAMS AND SENSATIONS", subTitle: "Push your limits", discoveryImage: UIImage(named: "disney")!)
        ]
    }
}
