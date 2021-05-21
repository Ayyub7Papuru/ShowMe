//
//  MockCoreDataStack.swift
//  ShowMeTests
//
//  Created by SayajinPapuru on 07/10/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import Foundation
import ShowMe
import CoreData

final class MockCoreDataStack: CoreDataStack {
    
    convenience init() {
        self.init(modelName: "ShowMe")
    }
    
    override init(modelName: String) {
        super.init(modelName: modelName)
        let persistentStoreDescription = NSPersistentStoreDescription()
               persistentStoreDescription.type = NSInMemoryStoreType
               let container = NSPersistentContainer(name: modelName)
               container.persistentStoreDescriptions = [persistentStoreDescription]
               container.loadPersistentStores { storeDescription, error in
                   if let error = error as NSError? {
                       fatalError("Unresolved error \(error), \(error.userInfo)")
                   }
               }
               self.persistentContainer = container
    }
}
