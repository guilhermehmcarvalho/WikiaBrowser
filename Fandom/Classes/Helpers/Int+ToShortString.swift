//
//  Int+ToShortString.swift
//  Fandom
//
//  Created by Guilherme on 08/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import Foundation

extension Int {
    // Returns the number in an abreviated string form
    func toShortString() -> String {
        var result = ""
        if self < 1000 {
            result = "\(self)"
        } else if self < 1000000 {
            let numb = self/1000
            result = "\(numb)k"
        } else if self < 1000000000000 {
            let numb = self/1000
            result = "\(numb)m"
        }
        return result
    }
}
