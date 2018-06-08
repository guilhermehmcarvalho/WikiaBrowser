//
//  Wiki.swift
//  Fandom
//
//  Created by Guilherme on 07/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import Foundation
import CoreData

@objc(WikiaItem)
class WikiaItem: NSManagedObject, Codable {
    
    // MARK: - Variables
    
    // Base
    @NSManaged var id: Int
    @NSManaged var name: String
    @NSManaged var domain: String
    @NSManaged var language: String
    @NSManaged var hub: String?
    @NSManaged var topic: String?
    
    // Expanded
    @NSManaged var headline: String?
    @NSManaged var desc: String
    @NSManaged var image: String?
    @NSManaged var url: String?
    @NSManaged var title: String
    @NSManaged var stats: WikiaStats?
    
    private enum CodingKeys: String, CodingKey { case id, name, domain, language, hub, topic, headline, desc, image, url, title, stats
    }
    
    public static let entityName = "WikiaItem"
    
    // MARK: - Decodable
    
    required convenience init(from decoder: Decoder) throws {
        
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext]
                as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: WikiaItem.entityName, in: managedObjectContext) else {
                fatalError("Failed to decode WikiaItem")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Base
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        domain = try container.decode(String.self, forKey: .domain)
        language = try container.decode(String.self, forKey: .language)
        hub = try container.decodeIfPresent(String.self, forKey: .hub)
        topic = try container.decodeIfPresent(String.self, forKey: .topic)
        
        // Expanded
        headline = try container.decodeIfPresent(String.self, forKey: .headline)
        desc = try container.decode(String.self, forKey: .desc)
        image = try container.decodeIfPresent(String.self, forKey: .image)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        title = try container.decode(String.self, forKey: .title)
        stats = try container.decode(WikiaStats.self, forKey: .stats)
    }
    
    // MARK: - Encodable
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        // Base
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(domain, forKey: .domain)
        try container.encode(language, forKey: .language)
        try container.encode(hub, forKey: .hub)
        try container.encode(topic, forKey: .topic)
        
        // Expanded
        try container.encode(headline, forKey: .headline)
        try container.encode(desc, forKey: .desc)
        try container.encode(image, forKey: .image)
        try container.encode(url, forKey: .url)
        try container.encode(title, forKey: .title)
        try container.encode(stats, forKey: .stats)
    }
}
