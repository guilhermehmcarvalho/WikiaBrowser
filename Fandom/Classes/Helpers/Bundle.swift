//
//  Bundle.swift
//  Fandom
//
//  Created by Guilherme on 07/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import Foundation

extension Bundle {
    
    func apiBaseUrl() -> String {
        return object(forInfoDictionaryKey: "ApiBaseUrl") as? String ?? ""
    }
}
