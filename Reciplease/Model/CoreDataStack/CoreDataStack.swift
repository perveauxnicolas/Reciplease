//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Perveaux Nicolas on 21/02/2024.
//

import Foundation
import CoreData

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
