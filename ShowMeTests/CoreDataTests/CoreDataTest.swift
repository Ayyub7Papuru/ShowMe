//
//  CoreDataTest.swift
//  ShowMeTests
//
//  Created by SayajinPapuru on 07/10/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import XCTest
import CoreData
@testable import ShowMe

class CoreDataTest: XCTestCase {

    var coreDataStack:  MockCoreDataStack!
    var coreDataManager: CoreDataManager!
    var data: Data?
    var placesFav: FavouritePlace?
    
    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        coreDataStack = nil
    }
    
    
    func testAddRecipeMethods_WhenARecipeIsCreated_ThenshouldBeCorrectlySaved() {
        coreDataManager.createPlace(name: "", address: "", image: Data(), rating: 0.0, longitude: 0.0, latitude: 0.0)
        XCTAssertFalse(coreDataManager.placesFav.isEmpty)
        XCTAssertTrue(coreDataManager.placesFav.count == 1)
    }
    
    func testDeleteAllRecipesMethod_WhenFavRecipesAreDeleted_ThenShouldCorrectlyDelete() {
        coreDataManager.createPlace(name: "", address: "", image: Data(), rating: 0.0, longitude: 0.0, latitude: 0.0)
        coreDataManager.deleteAllPlaces()
        XCTAssertTrue(coreDataManager.placesFav.isEmpty)
    }

    func testDeleteOneRecipeMethod_WhenARecipeIsRemoved_ThenShouldCorrectlyDelegte() {
        coreDataManager.createPlace(name: "", address: "", image: Data(), rating: 0.0, longitude: 0.0, latitude: 0.0)
        coreDataManager.deletePlace(named: "")
        XCTAssertTrue(coreDataManager.placesFav.isEmpty)
    }
    
    func testIsRegisteredMethod_WhenCheckingIfRecipeIsRegistered_ThenShouldBeRegistered() {
        coreDataManager.createPlace(name: "", address: "", image: Data(), rating: 0.0, longitude: 0.0, latitude: 0.0)
        XCTAssertTrue(coreDataManager.isPlaceRegistered(with: ""))
    }
    
    func testIsRegisteredMethod_WhenCheckingIfRecipeIsRegistered_ThenShouldnOTBeRegistered() {
        coreDataManager.createPlace(name: "", address: "", image: Data(), rating: 0.0, longitude: 0.0, latitude: 0.0)
        coreDataManager.deletePlace(named: "")
        
        XCTAssertFalse(coreDataManager.isPlaceRegistered(with: ""))
        XCTAssertTrue(coreDataManager.placesFav.isEmpty)
        
    }
}
