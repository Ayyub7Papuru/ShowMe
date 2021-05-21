//
//  CLLocationCoordinate+Extensions.swift
//  ShowMe
//
//  Created by SayajinPapuru on 14/07/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: CustomStringConvertible {
  public var description: String {
    let lat = String(format: "%.6f", latitude)
    let lng = String(format: "%.6f", longitude)
    return "\(lat),\(lng)"
  }
}
