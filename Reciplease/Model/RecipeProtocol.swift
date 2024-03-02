//
//  RecipeProtocol.swift
//  Reciplease
//
//  Created by Perveaux Nicolas on 27/02/2024.
//

import Foundation
import Alamofire

protocol RecipeProtocol {
    var urlStringApi: String { get }
    func request(url: URL, completionHandler: @escaping ((RecipeResult?, Error?) -> Void))
}

extension RecipeProtocol {
    var urlStringApi: String {
        return "https://api.edamam.com/api/recipes/v2?app_id=2240919c&app_key=3c06846444c8976134a85b34ff027ad7&type=public&q="
    }
}
