//
//  CoreDataManager.swift
//  Reciplease
//
//  Created by SayajinPapuru on 31/03/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import Foundation
import CoreData

protocol CoreData {
    func createPlace(name: String, address: String, rating: Double, longitude: Double, latitude: Double)
    func deleteAllPlaces()
    func deletePlace(named name: String)
    func isPlaceRegistered(with name: String) -> Bool
}

class CoreDataManager: CoreData {
    
    //MARK: - Properties
    
    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext
    
    var placesFav: [FavouritePlace] {
        let request: NSFetchRequest<FavouritePlace> = FavouritePlace.fetchRequest()
        guard let placesFav = try? managedObjectContext.fetch(request) else { return []}
        return placesFav
    }
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }
    
    //MARK: - Functions
    
    func createPlace(name: String, address: String, rating: Double, longitude: Double, latitude: Double){
        let placesFav = FavouritePlace(context: managedObjectContext)
        placesFav.name = name
        placesFav.address = address
        placesFav.rating = rating
        placesFav.latitude = latitude
        placesFav.longitude = longitude
        coreDataStack.saveContext()
    }
    
    func deleteAllPlaces() {
        placesFav.forEach { managedObjectContext.delete($0)}
        coreDataStack.saveContext()
    }
    
    func deletePlace(named name: String) {
        let request: NSFetchRequest<FavouritePlace> = FavouritePlace.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        guard let placesFav = try? managedObjectContext.fetch(request) else { return }
        guard let place = placesFav.first else { return }
        managedObjectContext.delete(place)
        coreDataStack.saveContext()
    }
    
    func isPlaceRegistered(with name: String) -> Bool {
        let request: NSFetchRequest<FavouritePlace> = FavouritePlace.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        guard let placesFav = try? managedObjectContext.fetch(request) else { return false }
        if placesFav.isEmpty {
            return false
        }
        return true
    }
}
