//
//  GoogleServiceTest.swift
//  ShowMeTests
//
//  Created by SayajinPapuru on 05/10/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import XCTest
@testable import ShowMe

class GoogleServiceTest: XCTestCase {
    
    func testFetchPlacesShouldPostFailedCallbackIfError() {
        let googleService = GoogleService(placeSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.googleServiceError))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        googleService.fetchPlacesNearCoordinate(types: [""], callback: { (result) in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testFetchPlacesShouldPostFailedCallbackIfAllError() {
        let googleService = GoogleService(placeSession: URLSessionFake(data: nil, response: nil, error: nil ))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        googleService.fetchPlacesNearCoordinate(types: [""], callback: { (result) in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testFetchPlacesShouldPostFailedCallbackIfResponseIncorrect() {
        let googleService = GoogleService(placeSession: URLSessionFake(data: FakeResponseData.googleServiceCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        googleService.fetchPlacesNearCoordinate(types: [""], callback: { (result) in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testFetchPlacesShouldPostFailedCallbackIfIncorrectData() {
        let googleService = GoogleService(placeSession: URLSessionFake(data: FakeResponseData.googleServiceIncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        googleService.fetchPlacesNearCoordinate(types: [""], callback: { (result) in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testFetchPlacesShouldPostSuccedCallbackIfCorrectDataAndResponseOK() {
        let googleService = GoogleService(placeSession: URLSessionFake(data: FakeResponseData.googleServiceCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        googleService.fetchPlacesNearCoordinate(types: [""], callback: { (result) in
            guard case .success(let results) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(results)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
}
