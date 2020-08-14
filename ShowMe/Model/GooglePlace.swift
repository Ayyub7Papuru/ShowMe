//
//  PlaceMarker.swift
//  ShowMe
//
//  Created by SayajinPapuru on 14/07/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation
import SwiftyJSON

class GooglePlace {
  let name: String
  let address: String
  let coordinate: CLLocationCoordinate2D
  let placeType: String
  let rating: Double
  var photoReference: String?
  var photo: UIImage?
  
  init(dictionary: [String: Any], acceptedTypes: [String])
  {
    let json = JSON(dictionary)
    name = json["name"].stringValue
    address = json["vicinity"].stringValue
    
    let lat = json["geometry"]["location"]["lat"].doubleValue as CLLocationDegrees
    let lng = json["geometry"]["location"]["lng"].doubleValue as CLLocationDegrees
    coordinate = CLLocationCoordinate2DMake(lat, lng)
    
    photoReference = json["photos"][0]["photo_reference"].string
    rating = json["rating"][0].double ?? 0.0
    
    var foundType = "restaurant"
    let possibleTypes = acceptedTypes.count > 0 ? acceptedTypes : ["bar", "grocery_or_supermarket", "restaurant", "atm", "cinema", "embassy", "gas_station", "hospital", "hotel", "museum", "park", "parking", "police", "shopping_mall", "tourist_attraction"]
    
    if let types = json["types"].arrayObject as? [String] {
      for type in types {
        if possibleTypes.contains(type) {
          foundType = type
          break
        }
      }
    }
      placeType = foundType
  }
}
