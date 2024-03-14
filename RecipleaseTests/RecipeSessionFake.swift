//
//  RecipeSessionFake.swift
//  RecipleaseTests
//
//  Created by Perveaux Nicolas on 06/03/2024.
//

import Foundation
@testable import Reciplease
/*
    class RecipeSessionFake: RecipeSession {
        private let fakeResponse: FakeResponse
        
        init(fakeResponse: FakeResponse) {
            self.fakeResponse = fakeResponse
        }
        
        override func request(url: URL, completionHandler: @escaping ((RecipeResult?, Error?)) -> Void) {
            let httpResponse = fakeResponse.response
            let data = fakeResponse.data
            let error = fakeResponse.error
            
            let result = Request.serializeResponseData(response: httpResponse, data: data, error: error)
            
            let url = Router2.searchRecipe
             let urlRequest = try? URLRequest(url: url, method: .get)
             completionHandler(DataResponse(request: urlRequest, response: httpResponse, data: data, result: result))
        }
    

private func createRecipeSearchUrl(ingredientsList: [String]) -> URL? {
    let ingredientUrl = ingredientsList.joined(separator: ",")
    guard let url = URL(string: urlStringApi + ingredientUrl) else { return nil }
    return url
}
}*/

class RecipeSessionResponse: RecipeProtocol {
    private let fakeResponse: FakeResponse
    init( fakeResponse: FakeResponse ) {
        self.fakeResponse = fakeResponse
    }
    func request(url: URL, completionHandler: @escaping ((RecipeResult?, Error?) -> Void)) {
        completionHandler(RecipeResult(hits: [Hit]()), nil)
    }
}

class RecipeSessionOkResponse: RecipeProtocol {
    private let fakeResponse: FakeResponse
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
    func request(url: URL, completionHandler: @escaping ((RecipeResult?, Error?) -> Void)) {
        completionHandler(RecipeResult(hits: [Hit]()), nil)
    }
}

class RecipeSessionKOResponse: RecipeProtocol {
    private let fakeResponse: FakeResponse
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
    func request(url: URL, completionHandler: @escaping ((RecipeResult?, Error?) -> Void)) {
        completionHandler(RecipeResult(hits: [Hit]()), nil)
    }
}

class RecipeSessionErrorResponse: RecipeProtocol {
    private let fakeResponse: FakeResponse
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
    func request(url: URL, completionHandler: @escaping ((RecipeResult?, Error?) -> Void)) {
        completionHandler(nil, fakeResponse.error)
    }
}
