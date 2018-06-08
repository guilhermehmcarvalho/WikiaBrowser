//
//  WikiaStats.swift
//  Fandom
//
//  Created by Guilherme on 08/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import Foundation
import CoreData

@objc(WikiaStats)
class WikiaStats: NSManagedObject, Codable {
    
    // MARK: - Variables
    
    @NSManaged var users: Int
    @NSManaged var articles: Int
    @NSManaged var pages: Int
    @NSManaged var admins: Int
    @NSManaged var activeUsers: Int
    @NSManaged var edits: Int
    @NSManaged var videos: Int
    @NSManaged var images: Int
    
    private enum CodingKeys: String, CodingKey { case users, articles, pages, admins, activeUsers, edits, videos, images
    }
    
    public static let entityName = "WikiaStats"
    
    // MARK: - Decodable
    
    required convenience init(from decoder: Decoder) throws {
        
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext]
                as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: WikiaStats.entityName, in: managedObjectContext) else {
                fatalError("Failed to decode WikiaStats")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Base
        users = try container.decode(Int.self, forKey: .users)
        articles = try container.decode(Int.self, forKey: .articles)
        pages = try container.decode(Int.self, forKey: .pages)
        admins = try container.decode(Int.self, forKey: .admins)
        activeUsers = try container.decode(Int.self, forKey: .activeUsers)
        edits = try container.decode(Int.self, forKey: .edits)
        videos = try container.decode(Int.self, forKey: .videos)
        images = try container.decode(Int.self, forKey: .images)
    }
    
    // MARK: - Encodable
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        // Base
        try container.encode(users, forKey: .users)
        try container.encode(articles, forKey: .articles)
        try container.encode(pages, forKey: .pages)
        try container.encode(admins, forKey: .admins)
        try container.encode(activeUsers, forKey: .activeUsers)
        try container.encode(edits, forKey: .edits)
        try container.encode(videos, forKey: .videos)
        try container.encode(images, forKey: .images)
    }
}
