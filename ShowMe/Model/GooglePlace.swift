//
//  GooglePlace.swift
//  ShowMe
//
//  Created by SayajinPapuru on 14/07/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import Foundation
import CoreLocation

struct GooglePlace: Codable {
  let name: String
  let address: String
  let types: [String]
  
  private let geometry: Geometry
  var coordinate: CLLocationCoordinate2D {
    return CLLocationCoordinate2D(latitude: geometry.location.lat, longitude: geometry.location.lng)
  }

  enum CodingKeys: String, CodingKey {
    case name
    case address = "vicinity"
    case types
    case geometry
  }
}

extension GooglePlace {
  struct Response: Codable {
    let results: [GooglePlace]
    let errorMessage: String?
  }
  
  private struct Geometry: Codable {
    let location: Coordinate
  }
  
  private struct Coordinate: Codable {
    let lat: CLLocationDegrees
    let lng: CLLocationDegrees
  }
}
