//
//  Wiki.swift
//  Fandom
//
//  Created by Guilherme on 07/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import Foundation
import CoreData

class WikiaItem: NSManagedObject, Codable {
    
    // MARK: - Variables
    
    @NSManaged var id: Int
    @NSManaged var name: String
    @NSManaged var domain: String
    @NSManaged var language: String
    @NSManaged var hub: String
    @NSManaged var topic: String
    
    private enum CodingKeys: String, CodingKey { case id, name, domain, language, hub, topic }
    
    // MARK: - Decodable
    
    required convenience init(from decoder: Decoder) throws {
        
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext]
                as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "WikiaItem", in: managedObjectContext) else {
                fatalError("Failed to decode WikiaItem")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        domain = try container.decode(String.self, forKey: .domain)
        language = try container.decode(String.self, forKey: .language)
        hub = try container.decode(String.self, forKey: .hub)
        topic = try container.decode(String.self, forKey: .topic)
    }
    
    // MARK: - Encodable
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(domain, forKey: .domain)
        try container.encode(language, forKey: .language)
        try container.encode(hub, forKey: .hub)
        try container.encode(topic, forKey: .topic)
    }
}

public extension CodingUserInfoKey {
    // Helper property to retrieve the context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
