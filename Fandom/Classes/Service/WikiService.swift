//
//  WikiService.swift
//  Fandom
//
//  Created by Guilherme on 07/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import Foundation

class WikiService: Service<RootResponse> {
    
    // MARK: - Variables
    
    weak public var delegate: WikiServiceDelegate?
    fileprivate let storeManager = WikiStoreManager()
    fileprivate var apiService: WikiApiService!
    
    // MARK: - Public
    
    func getTopWikis(page: Int? = nil) {
        apiService = WikiApiService().expand(1).batch(page)
        apiService.get(failure: self.failure, success: self.success)
    }
    
    // MARK: - Private
    
    private func success(data: Data) {
        storeManager.clearStorage()
        DispatchQueue.main.async {
            guard let response = self.jsonDecode(data) else {
                print("Error decoding RootResponse")
                self.failure(ServiceFailureType.encoding)
                return
            }
            self.delegate?.requestDidComplete(response.items)
        }
    }
    
    private func failure(_ failure: ServiceFailureType) {
        DispatchQueue.main.async {
            print(failure)
            let items = self.storeManager.fetchAll()
            self.delegate?.requestDidComplete(cachedItems: items, failure: failure)
        }
    }
}

// MARK: - Delegate Protocol

protocol WikiServiceDelegate: class {
    func requestDidComplete(_ items: [WikiaItem])
    func requestDidComplete(cachedItems: [WikiaItem], failure: ServiceFailureType)
}
