//
//  MapsViewModel.swift
//  ShowMe
//
//  Created by SayajinPapuru on 07/10/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import Foundation
import CoreLocation

class MapsViewModel {
    
    // MARK: - Public Properties
    
    public let dataProvider = GoogleService()
    public let searchRadius: Double = 10000
    public var googlePlace: GooglePlace?
    public var coreDataManager: CoreDataManager?
    public var searchedPlaces = [String]()
}
