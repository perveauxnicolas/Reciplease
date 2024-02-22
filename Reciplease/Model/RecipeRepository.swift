//
//  RecipeRepository.swift
//  Reciplease
//
//  Created by Perveaux Nicolas on 21/02/2024.
//

import Foundation
import CoreData


final class RecipeRepository {
    
    // MARK: - Properties
    private let coreDataStack: CoreDataStack
    
    // MARK: - Init
    init(coreDataStack: CoreDataStack = CoreDataStack.sharedInstance) {
        self.coreDataStack = coreDataStack
    }

    
    
    
}
