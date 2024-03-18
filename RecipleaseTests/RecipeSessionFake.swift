//
//  RecipeSessionFake.swift
//  RecipleaseTests
//
//  Created by Perveaux Nicolas on 06/03/2024.
//

import Foundation
@testable import Reciplease


class RecipeSessionFake: RecipeProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
    func request(url: URL, completionHandler: @escaping ((Reciplease.RecipeResult?, Error?) -> Void)) {
        do {
            let jsonData = try JSONDecoder().decode(RecipeResult.self, from: data!)
            completionHandler(jsonData, nil)
        } catch {
            completionHandler(nil, error)
        }
    }
}


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
