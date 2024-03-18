//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Perveaux Nicolas on 06/03/2024.
//

import Foundation

class FakeResponseData {
    
    // MARK: - Response
    static let responseOK = HTTPURLResponse(url: URL(string: "https://www.xxxxx.fr")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://www.xxxxx.fr")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    // MARK: - Data
    static var correctData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        guard let url = bundle.url(forResource: "Recipe", withExtension: "json") else {
            fatalError("Recipe.json is not found.")
        }
        guard let data = try? Data(contentsOf: url) else { return Data() }
        return data
    }
    static let incorrectData = "erreur".data(using: .utf8)!
    
    // MARK: - Error
    class NetworkError: Error {}
    static let networkError = NetworkError()
}
