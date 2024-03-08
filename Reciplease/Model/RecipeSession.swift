//
//  RecipeSession.swift
//  Reciplease
//
//  Created by Perveaux Nicolas on 27/02/2024.
//

import Foundation
import Alamofire

class RecipeSession:  RecipeProtocol {
    func request(url: URL, completionHandler: @escaping ((RecipeResult?, Error?) -> Void)) {
        AF.request(url)
            .response { response in
                switch response.result {
                case .success(let data):
                    do {
                        let jsonData = try JSONDecoder().decode(RecipeResult.self, from: data!)
                        completionHandler(jsonData, nil)
                    } catch {
                        print("error ceci n'est pas un ingredient")
                        completionHandler(nil, error)
                    }
                case .failure(let error):
                    print("error pas connexion internet")
                    completionHandler(nil, error)
                }
            }
    }
}
