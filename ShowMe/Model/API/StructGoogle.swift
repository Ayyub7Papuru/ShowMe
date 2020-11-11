//
//  StructGoogle.swift
//  ShowMe
//
//  Created by SayajinPapuru on 23/09/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import Foundation
import CoreLocation

// MARK: - Welcome
struct Welcome: Decodable {
    let results: [GooglePlace]
    let status: String
}

// MARK: - Result
struct GooglePlace: Decodable {
    let geometry: Geometry
    let name: String
    let photos: [Photo]?
    let rating: Double?
    let types: [String]
    let vicinity: String
}

// MARK: - Geometry
struct Geometry: Decodable {
    let location: Location
}

// MARK: - Location
struct Location: Decodable {
    let lat, lng: Double
}

// MARK: - Photo
struct Photo: Decodable {
    let height: Int
    let htmlAttributions: [String]
    let photoReference: String
    let width: Int

    enum CodingKeys: String, CodingKey {
        case height
        case htmlAttributions = "html_attributions"
        case photoReference = "photo_reference"
        case width
    }
}

func createGooglePlace(favoritePlace: FavouritePlace) -> GooglePlace {
    return GooglePlace(geometry: Geometry(location: Location(lat: favoritePlace.latitude, lng: favoritePlace.longitude)),
                       name: favoritePlace.name ?? "",
                       photos: nil,
                       rating: favoritePlace.rating,
                       types: [""],
                       vicinity: favoritePlace.address ?? "")
}
