//
//  WikiService.swift
//  Fandom
//
//  Created by Guilherme on 07/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import Foundation

class WikiService: Service<RootResponse> {
    
    private let apiService = WikiApiService()
    
    func getTopWikis() {
        apiService.get(failure: self.failure, success: self.success)
    }
    
    private func success(data: Data) {
        DispatchQueue.main.async {
            let items = self.jsonDecode(data)
            print(items)
        }
    }
    
    private func failure(_ failure: ServiceFailureType) {
        DispatchQueue.main.async {
            print(failure)
        }
    }
}
