//
//  ResearchViewController.swift
//  Reciplease
//
//  Created by Perveaux Nicolas on 20/02/2024.
//

import UIKit
import Alamofire

final class RecipeSearchViewController: UIViewController {
    
    // MARK: - Properties
    private let recipeLoader = RecipeLoader()
    private var ingredientsList = [String]()
    private var recipesList = [Hit]()
    private let segueToRecipesList = "segueToRecipesList"
    
    // MARK: - Outlets
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var ingredientTextView: UITextView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchRecipeActivityIndicator: UIActivityIndicatorView!
    
    // MARK: - Actions
    @IBAction func ValideAddIngredient(_ sender: Any) {
        ingredientTextField.resignFirstResponder()
        addIngredient()
    }
    @IBAction func clearIngredient(_ sender: Any) {
        clearListIngrdient()
    }
    @IBAction func SearchForRecipes(_ sender: Any) {
        searchRecipe()
    }
    
    // MARK: - Privates
    private func searchRecipe() {
        guard !ingredientsList.isEmpty else {
            presentAlert(typeError: .arrayIsEmpty)
            toggleActivityIndicator(shown: false, activityIndicator: searchRecipeActivityIndicator, validateButton: searchButton)
            return
        }
        recipeLoader.getRecipes(ingredientsList: ingredientsList) { (success, recipeResult) in
            self.toggleActivityIndicator(shown: false, activityIndicator: self.searchRecipeActivityIndicator, validateButton: self.searchButton)
            if success {
                guard let recipeResult = recipeResult else { return }
                self.recipesList = recipeResult.hits
                self.performSegue(withIdentifier: self.segueToRecipesList, sender: self)
            } else {
                self.presentAlert(typeError: .noRecipe)
                self.toggleActivityIndicator(shown: false, activityIndicator: self.searchRecipeActivityIndicator, validateButton: self.searchButton)
            }
        }
    }
    
    private func addIngredient() {
        guard let ingredientName = ingredientTextField.text,
              var ingredientListView = ingredientTextView.text else { return }
        ingredientsList.append(ingredientName)
        ingredientListView  += "- " + ingredientName + "\n"
        ingredientTextView.text = ingredientListView
        ingredientTextField.text = ""
    }
    
    private func clearListIngrdient(){
        ingredientTextView.text = ""
        ingredientsList = [String]()
    }
}
    
// MARK: - Extension
extension RecipeSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ ingredientTextField: UITextField) -> Bool {
        ingredientTextField.resignFirstResponder()
        addIngredient()
        return true
    }
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        ingredientTextField.resignFirstResponder()
    }
}

// MARK: - Navigation
extension RecipeSearchViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToRecipesList {
            guard let listRecipesVC = segue.destination as? RecipeListViewController else { return }
            listRecipesVC.recipesList = recipesList
        }
    }
}
