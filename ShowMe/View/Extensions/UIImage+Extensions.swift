//
//  UIImage+Extensions.swift
//  ShowMe
//
//  Created by SayajinPapuru on 30/09/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit

extension UIImage {
    
    var jpegRepresentationData: Data? {
        return self.jpegData(compressionQuality: 1.0)
    }
}
