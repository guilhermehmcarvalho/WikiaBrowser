//
//  RootResponse.swift
//  Fandom
//
//  Created by Guilherme on 07/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import Foundation

struct RootResponse: Decodable {
    let batches: Int?
    let items: [WikiaItem]
    let total: Int?
    let currentBatch: Int?
    let next: Int?
}
