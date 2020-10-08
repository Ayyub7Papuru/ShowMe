//
//  GoogleService.swift
//  ShowMe
//
//  Created by SayajinPapuru on 14/07/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import Foundation
import CoreLocation

enum PlacesError: Error {
    case NoData, NoResponse, NoJSON
}

class GoogleService {
    
    // MARK: - Private Properties
    
    private let googleAPIKey = "AIzaSyD1oGZHmqOXfhC_8MFpBgQ8ckSaHx4t0C4"
    private var placeSession: URLSession
    private var task: URLSessionTask?
    
    init(placeSession: URLSession = URLSession(configuration: .default)) {
        self.placeSession = placeSession
    }
    
    // MARK: - Public Methods
    
    func fetchPlacesNearCoordinate(_ coordinate: CLLocationCoordinate2D, radius: Double, types:[String], callback: @escaping (Result<Welcome, Error>) -> Void) {
        guard let url = URL(string: createUrlGooglePlace(coordinate, radius: radius, types: types)) else { return }
        
        task?.cancel()
        task = placeSession.dataTask(with: url) { (data, response, error) in
                guard let data = data, error == nil else {
                    callback(.failure(PlacesError.NoData))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(.failure(PlacesError.NoResponse))
                    return
                }
                
                guard let dataDecoded = try? JSONDecoder().decode(Welcome.self, from: data) else {
                    callback(.failure(PlacesError.NoJSON))
                    return
                }
            DispatchQueue.main.async {
                callback(.success(dataDecoded.self))
            }
                
        }
        task?.resume()
    }
    
    func fetchPhoto(reference: String) -> String {
        return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=200&photoreference=\(reference)&key=\(googleAPIKey)"
    }
    
    // MARK: - Private Properties
    
    fileprivate func createUrlGooglePlace(_ coordinate: CLLocationCoordinate2D, radius: Double, types:[String]) -> String {
        var urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(coordinate.latitude),\(coordinate.longitude)&radius=\(radius)&rankby=prominence&sensor=true&key=\(googleAPIKey)"
        let typesString = types.count > 0 ? types.joined(separator: "|") : "types"
        urlString += "&types=\(typesString)"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? urlString
        return urlString
    }
}
