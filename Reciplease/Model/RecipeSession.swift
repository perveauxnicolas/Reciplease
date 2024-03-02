//
//  RecipeSession.swift
//  Reciplease
//
//  Created by Perveaux Nicolas on 27/02/2024.
//

import Foundation
import Alamofire

class RecipeSession: RecipeProtocol {
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
}

/*
 .validate()
 .responseDecodable(of: RecipeResult.self) { (responseData) in
 guard responseData.value != nil else {return}
 }
 }
 }
 */
