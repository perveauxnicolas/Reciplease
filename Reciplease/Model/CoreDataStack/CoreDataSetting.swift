//
//  CoreDataSetting.swift
//  Reciplease
//
//  Created by Perveaux Nicolas on 03/03/2024.
//

import Foundation
import CoreData

final class CoreDataSetting {
    
    // MARK: - Properties
    private let coreDataStack: CoreDataStack 
    private let managedObjectContext: NSManagedObjectContext
    
    var recipes: [RecipeEntity] {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        guard let recipes = try? managedObjectContext.fetch(request) else { return [] }
        return recipes
    }
    
    // MARK: - Initializer
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }
    
    // MARK: - Manage Task Entity
    func createRecipe(title: String, ingredients: String, yield: Int16, time: Int16, image: String, url: String) {
        let recipe = RecipeEntity(context: managedObjectContext)
        recipe.title = title
        recipe.ingredients = ingredients
        recipe.yield = yield
        recipe.time = time
        recipe.image = image
        recipe.url = url
        coreDataStack.saveContext()
    }
    
    func deleteAllRecipes() {
        recipes.forEach { managedObjectContext.delete($0) }
        coreDataStack.saveContext()
    }
    
    func deleteRecipe(recipeTitle: String, url: String) {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", recipeTitle)
        request.predicate = NSPredicate(format: "url == %@", url)
        
        if let entity = try? managedObjectContext.fetch(request) {
            entity.forEach { managedObjectContext.delete($0) }
        }
        coreDataStack.saveContext()
    }
    
    func checkIfRecipeIsFavorite(recipeTitle: String, url: String) -> Bool {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", recipeTitle)
        request.predicate = NSPredicate(format: "url == %@", url)
        
        guard let counter = try? managedObjectContext.count(for: request) else { return false }
        return counter == 0 ? false : true
    }
    
}
