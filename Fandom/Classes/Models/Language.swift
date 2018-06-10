//
//  Language.swift
//  Fandom
//
//  Created by Guilherme Carvalho on 10/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import Foundation

enum Language: Int {
    case all
    case english
    case spanish
    case portuguese
    case polish
    
    var languageCode: String? {
        switch self {
        case .all:
            return nil
        case .english:
            return "en"
        case .spanish:
            return "es"
        case .portuguese:
            return "pt-br"
        case .polish:
            return "pl"
        }
    }
    
    var name: String {
        switch self {
        case .all:
            return "All"
        case .english:
            return "🇺🇸"
        case .spanish:
            return "🇪🇸"
        case .portuguese:
            return "🇧🇷"
        case .polish:
            return "🇵🇱"
        }
    }
    
    public static var allNames: [String] {
        var allValues: [String] = []
        var index = 0
        while let element = self.init(rawValue: index) {
            allValues.append(element.name)
            index += 1
        }
        
        return allValues
    }
}
