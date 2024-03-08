//
//  RecipeRepository.swift
//  Reciplease
//
//  Created by Perveaux Nicolas on 21/02/2024.
//

import Foundation
import Alamofire

final class RecipeLoader {
    // MARK: - Properties
    private let recipeSession: RecipeProtocol
    
    init(recipeSession: RecipeProtocol = RecipeSession()) {
        self.recipeSession = recipeSession
    }
    
    // MARK: - Methods
    func getRecipes(ingredientsList: [String], completionHandler: @escaping (Bool, RecipeResult?) -> Void) {
        guard let url = createRecipeSearchUrl(ingredientsList: ingredientsList) else { return }
        recipeSession.request(url: url) { recipeResult,error  in
            completionHandler(true, recipeResult)
        }
    }

    private func createRecipeSearchUrl(ingredientsList: [String]) -> URL? {
        let ingredientUrl = ingredientsList.joined(separator: ",")
        guard let url = URL(string: recipeSession.urlStringApi + ingredientUrl) else { return nil }
        return url
    }
    
}
