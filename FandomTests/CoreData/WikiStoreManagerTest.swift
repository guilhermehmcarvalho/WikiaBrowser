//
//  WikiStoreManagerTest.swift
//  FandomTests
//
//  Created by Guilherme Carvalho on 09/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import XCTest
import CoreData
@testable import Fandom

class WikiStoreManagerTest: XCTestCase {
    
    // MARK: - Variables
    
    private var storeManager: WikiStoreManager!
    
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
    
    private var saveNotificationCompleteHandler: ((Notification) -> Void)?
    
    // MARK: - Private
    
    private func initStubs() {
        func createEntity(name: String) {
            guard let entity = NSEntityDescription.insertNewObject(forEntityName: WikiaItem.entityName,
                                                                   into: mockPersistantContainer.viewContext)
                as? WikiaItem else {
                    fatalError("Error creating WikiaItem entity")
            }
            
            entity.name = name
            entity.timestamp = Date()
        }
        
        createEntity(name: "test")
        createEntity(name: "test2")
        
        do {
            try mockPersistantContainer.viewContext.save()
        } catch {
            print("create fakes error \(error)")
        }
    }
    
    @objc private func contextSaved( notification: Notification ) {
        saveNotificationCompleteHandler?(notification)
    }
    
    private func waitForSavedNotification(completeHandler: @escaping ((Notification) -> Void) ) {
        saveNotificationCompleteHandler = completeHandler
    }
    
    func flushData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: WikiaItem.entityName)
        do {
            let objs = try mockPersistantContainer.viewContext.fetch(fetchRequest)
            for case let obj as NSManagedObject in objs {
                mockPersistantContainer.viewContext.delete(obj)
            }
            
            try mockPersistantContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }
    
    // MARK: - XCTestCase
    
    override func setUp() {
        super.setUp()
        storeManager = WikiStoreManager(container: mockPersistantContainer)
        initStubs()
        NotificationCenter.default.addObserver( self,
                                                selector: #selector(contextSaved(notification:)),
                                                name: NSNotification.Name.NSManagedObjectContextDidSave ,
                                                object: nil )
    }
    
    override func tearDown() {
        super.tearDown()
        flushData()
    }
    
    // MARK: - Tests
    
    func testFetchAll() {
        let items = storeManager.fetchAll()
        XCTAssertEqual(items.count, 2)
    }
    
    func testClearStorage() {
        storeManager.clearStorage()
        let items = storeManager.fetchAll()
        XCTAssertEqual(items.count, 0)
    }
    
}
