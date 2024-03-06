//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by Perveaux Nicolas on 20/02/2024.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var recipeDetailsImageView: UIImageView!
    @IBOutlet weak var yieldDetailsLabel: UILabel!
    @IBOutlet weak var timeDetailsLabel: UILabel!
    @IBOutlet weak var titleRecipeDetailsLabel: UILabel!
    @IBOutlet weak var ingredientsDetailsTextView: UITextView!
    @IBOutlet weak var FavoritesButton: UIBarButtonItem!
    @IBOutlet weak var instructionsButton: UIButton!
    
    // MARK: - Properties
    var cellule: Hit?
    private var coreDataSetting: CoreDataSetting?
    private var recipeIsFavorite = false
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataFunction()
        addShadowTexte(label: titleRecipeDetailsLabel)
        configureRecipe()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkIfRecipeIsFavorite()
    }
    // MARK: - Actions
    @IBAction func favoriteButtonTapped(_ sender: UIBarButtonItem) {
        checkIfRecipeIsFavorite()
        !recipeIsFavorite ?
        addRecipeToFavorites() :
        deleteRecipeFavorite(recipeTitle: cellule?.recipe.label, url: cellule?.recipe.url, CoreDataSetting: coreDataSetting, favoriteButton: FavoritesButton)
    }
    
    @IBAction func instructionsButtonTapped(_ sender: UIButton) {
        guard let celluleRecipeUrl = cellule?.recipe.url else { return }
        webSiteRecipe(urlString: celluleRecipeUrl)
    }
    
    // MARK: - Privates
    private func coreDataFunction() {
        let coreDataStack = CoreDataStack(modelName: "Reciplease")
        coreDataSetting = CoreDataSetting(coreDataStack: coreDataStack)
    }
    
    private func configureRecipe() {
        guard let ingredientLines = cellule?.recipe.ingredientLines.joined(separator: "\n" + "- ") else { return }
        guard let yield = cellule?.recipe.yield else { return }
        guard let image = cellule?.recipe.image else { return }
        let totalTimeInt = cellule?.recipe.totalTime ?? 0
        
        ingredientsDetailsTextView.text = "- " + ingredientLines
        titleRecipeDetailsLabel.text = cellule?.recipe.label.localizedCapitalized
        yieldDetailsLabel.text = String(yield)
        recipeDetailsImageView.load(urlImageString: image)
        timeDetailsLabel.text = String(totalTimeInt)
    }
    
    private func checkIfRecipeIsFavorite() {
        guard let recipeTitle = cellule?.recipe.label else { return }
        guard let url = cellule?.recipe.url else { return }
        guard let checkIsRecipeIsFavorite = coreDataSetting?.checkIfRecipeIsFavorite(recipeTitle: recipeTitle, url: url) else { return }
        recipeIsFavorite = checkIsRecipeIsFavorite
        
        if recipeIsFavorite {
            FavoritesButton.tintColor = UIColor.green
        } else {
            FavoritesButton.tintColor = .none
        }
    }
    
    private func addRecipeToFavorites() {
        guard let label = cellule?.recipe.label else { return }
        guard let ingredients = cellule?.recipe.ingredientLines.joined(separator: "\n" + "- ") else { return }
        guard let yield = cellule?.recipe.yield else { return }
        let totalTime = Int16(cellule?.recipe.totalTime ?? 0)
        guard let image = cellule?.recipe.image else { return }
        guard let url = cellule?.recipe.url else { return }
        
        coreDataSetting?.createRecipe(title: label.localizedCapitalized,
                                      ingredients: "- " + ingredients,
                                      yield: Int16(yield),
                                      time: totalTime,
                                      image: image, url: url)
        setupFavoriteButton(color: .green, barButtonItem: FavoritesButton)
        
        debugFavorites(titleDebug: "Favorite created", coreDataSetting: coreDataSetting)
    }
    
}
