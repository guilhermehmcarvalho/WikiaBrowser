//
//  AppDelegate.swift
//  Fandom
//
//  Created by Guilherme on 07/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		return true
	}

	// MARK: - Core Data stack

	lazy var persistentContainer: NSPersistentContainer = {
	    let container = NSPersistentContainer(name: "Fandom")
	    container.loadPersistentStores(completionHandler: { (_, error) in
	        if let error = error as NSError? {
	            fatalError("Unresolved error \(error), \(error.userInfo)")
	        }
	    })
	    return container
	}()

	// MARK: - Core Data Saving support

	func saveContext () {
	    let context = persistentContainer.viewContext
	    if context.hasChanges {
	        do {
	            try context.save()
	        } catch {
	            let nserror = error as NSError
	            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
	        }
	    }
	}

}
