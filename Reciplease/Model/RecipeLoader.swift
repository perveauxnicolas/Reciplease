//
//  RecipeRepository.swift
//  Reciplease
//
//  Created by Perveaux Nicolas on 21/02/2024.
//

import Foundation
import Alamofire
//import CoreData


final class RecipeLoader {
    // MARK: - Properties
    private let recipeSession: RecipeProtocol
    
    init(recipeSession: RecipeProtocol = RecipeSession()) {
        self.recipeSession = recipeSession
    }
    
    // MARK: - Methods
    func getRecipes(ingredientsList: [String], completionHandler: @escaping (Bool, RecipeResult?) -> Void) {
        guard let url = createRecipeSearchUrl(ingredientsList: ingredientsList) else { return }
        recipeSession.request(url: url) { RecipeResult,error  in
            completionHandler(true, RecipeResult)
        }
    }

    private func createRecipeSearchUrl(ingredientsList: [String]) -> URL? {
        let ingredientUrl = ingredientsList.joined(separator: ",")
        guard let url = URL(string: recipeSession.urlStringApi + ingredientUrl) else { return nil }
        print(url)
        return url
    }
}
