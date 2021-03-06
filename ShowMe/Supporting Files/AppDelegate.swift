//
//  AppDelegate.swift
//  ShowMe
//
//  Created by SayajinPapuru on 18/06/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit
import CoreData
import GooglePlaces
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    public var window: UIWindow?
    public lazy var coreDataStack = CoreDataStack(modelName: "ShowMe")
    
    private let googleAPIKey = "AIzaSyD1oGZHmqOXfhC_8MFpBgQ8ckSaHx4t0C4"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey(googleAPIKey)
        GMSPlacesClient.provideAPIKey(googleAPIKey)
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        coreDataStack.saveContext()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        coreDataStack.saveContext()
    }
}

