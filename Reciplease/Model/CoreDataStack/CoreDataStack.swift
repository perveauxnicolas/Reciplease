//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Perveaux Nicolas on 21/02/2024.
//

import Foundation
import CoreData

final class CoreDataStack { 
    // MARK: - Properties
    private var modelName = "Reciplease"

    // MARK: - Initializer
    public init(modelName: String) {
        self.modelName = modelName
    }
    
    // MARK: - Core Data stack
    public lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    public lazy var mainContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    public func saveContext() {
        guard mainContext.hasChanges else { return }
        do {
            try mainContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}








/*
 final class CoreDataStack {
 
 private let persistanteCountainerName = "Reciplease"
 
 // MARK: - Singleton
 static let sharedInstance = CoreDataStack()
 
 // MARK: - Public
 var viewContext: NSManagedObjectContext {
 return CoreDataStack.sharedInstance.persistentContainer.viewContext
 }
 
 // MARK: - Private
 private init() {}
 
 private lazy var persistentContainer: NSPersistentContainer = {
 let container = NSPersistentContainer(name: persistanteCountainerName)
 container.loadPersistentStores(completionHandler: { (storeDescription, error) in
 if let error = error as NSError? {
 fatalError("Unresolved error \(error), \(error.userInfo) for: \(storeDescription.description)")
 }
 })
 return container
 }()
 }
 */
