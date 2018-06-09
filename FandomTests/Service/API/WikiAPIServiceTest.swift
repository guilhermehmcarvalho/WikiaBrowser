//
//  WikiAPIServiceTest.swift
//  FandomTests
//
//  Created by Guilherme Carvalho on 09/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import XCTest
import CoreData
@testable import Fandom

class WikiAPIServiceTest: APIServiceTest {
    
    private var service: WikiApiService!
    
    // MARK: - Variables
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        return managedObjectModel
    }()

    lazy var mockPersistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Fandom", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores(completionHandler: { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )
            
            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        })
        
        return container
    }()
    
    // MARK: - Test
    
    // Test get using a mock persistant container to decode WikiaItem object inside RootResponse model
    func testGet() {
        service = WikiApiService()
        service.get(failure: { failure in
            self.failure(failure)
        },
        success: { data in
            do {
                guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                    fatalError("Failed to retrieve context")
                }
                
                let decoder = JSONDecoder()
                decoder.userInfo[codingUserInfoKeyManagedObjectContext] =
                    self.mockPersistantContainer.newBackgroundContext()
                _ = try decoder.decode(RootResponse.self, from: data)
                self.success()
            } catch let error {
                print("Parse error: \(error)")
                self.failure(.server)
            }
        })
        
        waitForExpectations(timeout: ApiService.ApiServiceParams.timeout, handler: nil)
    }
    
}
