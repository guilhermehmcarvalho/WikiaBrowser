//
//  WikiStoreManager.swift
//  Fandom
//
//  Created by Guilherme Carvalho on 07/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import UIKit
import CoreData

class WikiStoreManager: NSObject {
    
    // MARK: - Variables
    
    let persistantContainer: NSPersistentContainer!
    
    /**
     - Parameters:
     - container: NSPersistentContainer Dependency injection for tests
     */
    init(container: NSPersistentContainer) {
        self.persistantContainer = container
        self.persistantContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    override convenience init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Can not get shared app delegate")
        }
        
        self.init(container: appDelegate.persistentContainer)
    }
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistantContainer.newBackgroundContext()
    }()
    
    // MARK: - CRUD
    
    func clearStorage() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: WikiaItem.entityName)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try backgroundContext.execute(batchDeleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
    // Fetch all Items sorted by date
    func fetchAll() -> [WikiaItem] {
        var results = [WikiaItem]()
        
        guard let request: NSFetchRequest<WikiaItem> = WikiaItem.fetchRequest() as? NSFetchRequest<WikiaItem>
            else { fatalError("Unable to fetch WikiaItem") }
        do {
            let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: true)
            request.sortDescriptors = [sortDescriptor]
            results = try backgroundContext.fetch(request)
        } catch let error { print("Error fetching WikiaItem: \(error)") }
        
        return results
    }
}
