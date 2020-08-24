//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by SayajinPapuru on 31/03/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import Foundation
import CoreData

open class CoreDataStack {
    
    private let modelName: String
    
    public init(modelName: String) {
         self.modelName = modelName
     }
    
    public lazy var persistentContainer: NSPersistentContainer = {
          let container = NSPersistentContainer(name: modelName)
          container.loadPersistentStores(completionHandler: { (storeDescription, error) in
              if let error = error as NSError? {
                  fatalError("Unresolved error \(error), \(error.userInfo)")
              }
          })
          return container
      }()

      public lazy var mainContext: NSManagedObjectContext = {
          return persistentContainer.viewContext
      }()

      public func saveContext() {
          guard mainContext.hasChanges else { return }
          do {
              try mainContext.save()
          } catch let error as NSError {
              print("Unresolved error \(error), \(error.userInfo)")
          }
      }
}
