//
//  ExpandedWikiaItem.swift
//  Fandom
//
//  Created by Guilherme on 07/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import Foundation

class ExpandedWikiaItem {
    
    var headline: String
    var desc: String
    var image: String
    var url: String
    
    private enum CodingKeys: String, CodingKey { case headline, desc, image, url }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        headline = try container.decode(String.self, forKey: .headline)
        desc = try container.decode(String.self, forKey: .desc)
        image = try container.decode(String.self, forKey: .image)
        url = try container.decode(String.self, forKey: .url)
        let superdecoder = try container.superDecoder()
        //try super.init(from: superdecoder)
    }
}
