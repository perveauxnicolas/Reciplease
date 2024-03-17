//
//  RecipeSessionFake.swift
//  RecipleaseTests
//
//  Created by Perveaux Nicolas on 06/03/2024.
//

import Foundation
@testable import Reciplease


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
