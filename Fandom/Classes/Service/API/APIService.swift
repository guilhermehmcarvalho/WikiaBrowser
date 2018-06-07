//
//  APIService.swift
//  Fandom
//
//  Created by Guilherme on 07/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import Foundation
import Alamofire

class ApiService {
    
    // MARK: - Variables
    
    let sessionManager: SessionManager = {
        let conf = URLSessionConfiguration.default
        conf.timeoutIntervalForRequest = ApiServiceParams.timeout
        conf.timeoutIntervalForResource = ApiServiceParams.timeout
        return SessionManager(configuration: conf)
    }()
    
    // MARK: - Other
    
    struct ApiServiceParams {
        static let baseUrl = URL(string: Bundle.main.apiBaseUrl())!
        static let timeout: Double = 15
    }
}
