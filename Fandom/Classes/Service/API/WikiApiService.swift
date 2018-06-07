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
    
    // MARK: - Variables
    
    fileprivate(set) var expand: Int?
    fileprivate(set) var hub: String?
    fileprivate(set) var lang: String?
    fileprivate(set) var limit: Int?
    fileprivate(set) var batch: Int?
    
    // MARK: - Builder
    
    fileprivate var _builder: WikiApiService?
    
    fileprivate var builder: WikiApiService {
        if _builder == nil {
            _builder = WikiApiService()
        }
        return _builder!
    }
    
    // MARK: - Public
    
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
                
            success(data)
        }
    }
    
    // MARK: - Private
    
    fileprivate struct APIParameterKey {
        static let hub = "hub"
        static let lang = "lang"
        static let limit = "limit"
        static let batch = "batch"
        static let expand = "expand"
    }
    
    private func parameters() -> [String: Any] {
        
        var params: Parameters = [:]
        
        if let expand = expand {
            params[APIParameterKey.expand] = expand
        }
        
        if let lang = lang {
            params[APIParameterKey.lang] = lang
        }
        
        if let hub = hub {
            params[APIParameterKey.hub] = hub
        }
        
        if let limit = limit {
            params[APIParameterKey.limit] = limit
        }
        
        if let batch = batch {
            params[APIParameterKey.batch] = batch
        }
        
        return params
    }
}

extension WikiApiService {
    func expand(_ value: Int) -> Self {
        builder.expand = value
        return self
    }
    
    func lang(_ value: String) -> Self {
        builder.lang = lang
        return self
    }
    
    func hub(_ value: String) -> Self {
        builder.hub = hub
        return self
    }
    
    func limit(_ value: Int) -> Self {
        builder.limit = value
        return self
    }
    
    func batch(_ value: Int) -> Self {
        builder.batch = value
        return self
    }
}
