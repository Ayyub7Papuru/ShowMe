//
//  GoogleService.swift
//  ShowMe
//
//  Created by SayajinPapuru on 14/07/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

enum PlacesError: Error {
    case NoData, NoResponse, NoJSON
}

typealias PlacesCompletion = ([GooglePlace]) -> Void
typealias PhotoCompletion = (UIImage) -> Void

class GoogleService {
    private let googleAPIKey = "AIzaSyD1oGZHmqOXfhC_8MFpBgQ8ckSaHx4t0C4"
    private var photosDictionnary: [String: String] = [:]
    private var placesTask: URLSessionDataTask?
    private var session: URLSession {
        return URLSession.shared
    }
    
    func fetchPlaces(near coordinate: CLLocationCoordinate2D, radius: Double, types: [String], callback : @escaping PlacesCompletion) -> Void {
        
        var callURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(coordinate)&radius=\(radius)&rankby=prominence&sensor=true&key=\(googleAPIKey)"
        let typesString = types.count > 0 ? types.joined(separator: "|") : "places"
        callURL += "&types=\(typesString)"
        callURL = callURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? callURL
        
        guard let url = URL(string: callURL) else {
            callback([])
            return
        }
        
        if let task = placesTask, task.taskIdentifier > 0 && task.state == .running {
            task.cancel()
        }
        
        placesTask = session.dataTask(with: url) { data, response, _ in
            guard let data = data else {
                DispatchQueue.main.async {
                    callback([])
                }
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let placesResponse = try? decoder.decode(GooglePlace.Response.self, from: data) else {
                DispatchQueue.main.async {
                    callback([])
                }
                return
            }
            
            if let errorMessage = placesResponse.errorMessage {
                print(errorMessage)
            }
            
            DispatchQueue.main.async {
                callback(placesResponse.results)
            }
        }
        placesTask?.resume()
    }
}
