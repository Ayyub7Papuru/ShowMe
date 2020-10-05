//
//  FakeResponseData.swift
//  ShowMeTests
//
//  Created by SayajinPapuru on 05/10/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import Foundation

class FakeResponseData {
    static  let responseOK = HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class GoogleServiceError: Error {}
    static let googleServiceError = GoogleServiceError()
    
    static var googleServiceCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "GoogleService", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static let googleServiceIncorrectData = "error".data(using: .utf8)!
}
