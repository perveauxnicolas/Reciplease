//
//  UIViewController+Helpers.swift
//  Reciplease
//
//  Created by Perveaux Nicolas on 28/02/2024.
//

import UIKit

// MARK: - Extension to manage the ActivityIndicator
extension UIViewController {
    func toggleActivityIndicator(shown: Bool, activityIndicator: UIActivityIndicatorView, validateButton: UIButton) {
        activityIndicator.isHidden = !shown
        validateButton.isHidden = shown
    }
}

// MARK: - Extension to display a alert message to the user
extension UIViewController {
    // Enumeration of the error
    enum AlertError {
        case arrayIsEmpty
        case noRecipe
        case incorrectIngredient
    }
    // Alert message to user
    func presentAlert(typeError: AlertError) {
        var message: String
        var title: String
        
        switch typeError {
        case .arrayIsEmpty:
            title = "No ingredient"
            message = "Please add an ingredient."
        case .noRecipe:
            title = "No recipe"
            message = "Sorry there is no recipe."
        case .incorrectIngredient:
            title = "Incorrect ingredient"
            message = "Sorry there is not good ingredient."

        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

func addShadowTexte(label: UILabel) {
    label.layer.shadowColor = UIColor.black.cgColor
    label.layer.shadowOpacity = 0.9
    label.layer.shadowOffset = CGSize(width: 1, height: 1)
    label.layer.shadowRadius = 2
}

// MARK: - Extension to open url
extension UIViewController {
    func webSiteRecipe(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
}

// MARK: - Extension to delete favorites and manage the button of favorites
extension UIViewController {
    // Delete favorite
    func deleteRecipeFavorite(recipeTitle: String?, url: String?, CoreDataSetting: CoreDataSetting?, favoriteButton: UIBarButtonItem) {
        CoreDataSetting?.deleteRecipe(recipeTitle: recipeTitle ?? "", url: url ?? "")
        setupFavoriteButton(color: .white, barButtonItem: favoriteButton)
        debugFavorites(titleDebug: "Favorite deleted", coreDataSetting: CoreDataSetting)
    }
    
    // Setting the button favorite
    func setupFavoriteButton(color: UIColor, barButtonItem: UIBarButtonItem) {
        barButtonItem.tintColor = color
        navigationItem.rightBarButtonItem = barButtonItem
    }
}

// MARK: - Extension to debug
extension UIViewController {
    // function to debug
    func debugFavorites(titleDebug: String, coreDataSetting: CoreDataSetting?) {
        print(titleDebug)
        print("-----------------------")
        var index = 0
        for recipe in coreDataSetting?.recipes ?? [RecipeEntity]() {
            print("Recipes N° \(index + 1) :")
            print("time : \(String(recipe.time))")
            print("Servings : \(recipe.yield)")
            print(recipe.image ?? "image error")
            print(recipe.url ?? "url error")
            print(recipe.title ?? "title error")
            print(recipe.ingredients ?? "ingredients error")
            print("\n")
            index += 1
        }
    }
}

// MARK: - Extension to timeformat
extension Int {
    // Formatting an integer (in minutes) in time
    var formatToStringTime: String {
        if self <= 0 {
            return "N/A"
        } else {
            let minutes = self % 60
            let hours = self / 60
            
            if hours == 0 {
                return "\(minutes)min"
            } else if minutes == 0 {
                return "\(hours)h"
            } else {
                return "\(hours)h \(minutes)min"
            }
        }
    }
}


