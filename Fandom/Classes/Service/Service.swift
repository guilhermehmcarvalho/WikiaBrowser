//
//  Service.swift
//  Fandom
//
//  Created by Guilherme on 07/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import UIKit
import CoreData

class Service<T: Decodable>: NSObject {
    
    private let persistentContainer: NSPersistentContainer
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    override convenience init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Can not get shared app delegate")
        }
        
        self.init(persistentContainer: appDelegate.persistentContainer)
    }
    
    // MARK: - Public
    
    func jsonDecode(_ data: Data) -> T? {
        do {
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                fatalError("Failed to retrieve context")
            }
            
            let decoder = JSONDecoder()
            decoder.userInfo[codingUserInfoKeyManagedObjectContext] = backgroundContext
            let decodedObject = try decoder.decode(T.self, from: data)
            try backgroundContext.save()
            return decodedObject
        } catch let error {
            print("Error @ Service/jsonDecode: \(error)")
            return nil
        }
    }
    
    /*func jsonDecodeArray(_ data: Data) -> [T]? {
        do {
            let decodedObjects = try JSONDecoder().decode([T].self, from: data)
            try backgroundContext.save()
            return decodedObjects
        } catch let error {
            print("Error @ Service/jsonDecodeArray: \(error)")
            return nil
        }
    }*/
    
}

// MARK: - Others

enum ServiceFailureType {
    case connection
    case server
}
