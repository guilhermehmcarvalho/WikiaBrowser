//
//  WikiApiService.swift
//  Fandom
//
//  Created by Guilherme on 07/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import Foundation
import Alamofire

class WikiApiService: ApiService {
    
    func get(failure: @escaping (ServiceFailureType) -> Void,
             success: @escaping (Data) -> Void) {
        _ = self.sessionManager.request(APIRouter.wikis(
            params: self.parameters()))
            .validate(statusCode: [200])
            .responseJSON { response in
                
            guard let data = response.data else {
                failure(.connection)
                return
            }
            
            if let error = response.error {
                
                if let result = response.result.value {
                    if let JSON = result as? [NSDictionary] {
                        print(JSON)
                    }
                }
                
                if error as? AFError == nil {
                    failure(.connection)
                } else {
                    failure(.server)
                }
                
                return
            }
                
                if let result = response.result.value {
                    if let JSON = result as? NSDictionary {
                        print(JSON)
                    }
                }
                
                do {
                    let rootResponse = try JSONDecoder().decode(RootResponse.self, from: data)
                    print(rootResponse)
                } catch let error { print("Error parsing root response: \(error)") }
                
            success(data)
        }
    }
    
    struct APIParameterKey {
        static let hub = "hub"
        static let lang = "lang"
        static let limit = "limit"
        static let batch = "batch"
    }
    
    private func parameters() -> [String: Any] {
        
        var params: Parameters = [:]
        
        return params
    }
    
}
