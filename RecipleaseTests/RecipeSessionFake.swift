//
//  RecipeSessionFake.swift
//  RecipleaseTests
//
//  Created by Perveaux Nicolas on 06/03/2024.
//

import Foundation
import Alamofire
@testable import Reciplease

class RecipeSessionFake: RecipeProtocol {
    
    private let fakeResponse: FakeResponse
    
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
    
    func request(url: URL, completionHandler: @escaping ((RecipeResult?, Error?) -> Void)) {
        AF.request(url)
            .response { response in
                switch response.result {
                case .success(let data):
                    do {
                        let jsonData = try JSONDecoder().decode(RecipeResult.self, from: data!)
                        completionHandler(jsonData, nil)
                    } catch {
                        completionHandler(nil, error)
                    }
                case .failure(let error):
                    completionHandler(nil, error)
                }
            }
    }
    
    private func createRecipeSearchUrl(ingredientsList: [String]) -> URL? {
        let ingredientUrl = ingredientsList.joined(separator: ",")
        guard let url = URL(string: urlStringApi + ingredientUrl) else { return nil }
        return url
    }
}
