//
//  PlacesSession.swift
//  ShowMe
//
//  Created by SayajinPapuru on 18/06/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import Foundation
import Alamofire

protocol AlamoSession {
    func request(with url: URL, callBack: @escaping (DataResponse<Any>) -> Void)
}

class PlacesSession: AlamoSession {
    func request(with url: URL, callBack: @escaping (DataResponse<Any>) -> Void) {
        Alamofire.request(url).responseJSON { responseData in
            callBack(responseData)
        }
    }
}
