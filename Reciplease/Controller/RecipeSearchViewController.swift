//
//  ResearchViewController.swift
//  Reciplease
//
//  Created by Perveaux Nicolas on 20/02/2024.
//

import UIKit

final class RecipeSearchViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - Outlets
    @IBOutlet weak var IngredientTextField: UITextField!
    @IBOutlet weak var IngredientTextView: UITextView!
    
    // MARK: - View life cycle
    
    // MARK: - Actions
    

    
    
    
    @IBAction func ValideAddIngredient(_ sender: Any) {
        addIngredient()
    }
    @IBAction func clearIngredient(_ sender: Any) {
    }
    @IBAction func SearchForRecipes(_ sender: Any) {
    }
    
    // MARK: - Private
    
    private func addIngredient() {
        guard let ingredientName = IngredientTextField.text,
              var ingredientList = IngredientTextView.text else { return }
        
        ingredientList += "- " + ingredientName + "\n"
        IngredientTextView.text = ingredientList
        IngredientTextField.text = ""
    }
    
}

// MARK: - Extension

extension RecipeSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        addIngredient()
        return true
    }
}

