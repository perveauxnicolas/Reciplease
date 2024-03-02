//
//  UIViewController.swift
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

