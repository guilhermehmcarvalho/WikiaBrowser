//
//  APIRouter.swift
//  Fandom
//
//  Created by Guilherme on 07/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    // MARK: - Router
    
    case wikis(params:Parameters)
    
    // MARK: - Private
    
    private var method: HTTPMethod {
        switch self {
        case .wikis: return .get
        }
    }
    
    private var path: String {
        switch self {
        case .wikis: return "/api/v1/Wikis/List"
        }
    }
    
    // MARK: - URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: ApiService.ApiServiceParams.baseUrl.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        // Parameters
        switch self {
        case .wikis(let params):
            do {
                urlRequest = try URLEncoding.queryString.encode(urlRequest, with: params)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
