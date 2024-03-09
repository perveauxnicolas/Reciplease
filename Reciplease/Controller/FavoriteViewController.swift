//
//  FavoritesViewController.swift
//  Reciplease
//
//  Created by Perveaux Nicolas on 20/02/2024.
//

import UIKit

class FavoriteViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var FavoriteDetailsImageView: UIImageView!
    @IBOutlet weak var titleFavoriteDetailsLabel: UILabel!
    @IBOutlet weak var ingredientsFavoriteDetailsTextView: UITextView!
    @IBOutlet weak var instructionsButton: UIButton!
    @IBOutlet weak var FavoritesButton: UIBarButtonItem!
    @IBOutlet weak var yieldFavoriteLabel: UILabel!
    @IBOutlet weak var timeFavoriteLabel: UILabel!
    
    // MARK: - Properties
    var cellule: RecipeEntity?
    private var coreDataSetting: CoreDataSetting?
    private var recipeIsFavorite = false
    
    // MARK: - Actions
    @IBAction func favoriteButtonTapped(_ sender: UIBarButtonItem) {
        checkIfRecipeIsFavorite()
        deleteRecipeFavorite(recipeTitle: cellule?.title, url: cellule?.url, CoreDataSetting: coreDataSetting, favoriteButton: FavoritesButton)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func instructionsButtonTapped(_ sender: UIButton) {
        guard let celluleRecipeUrl = cellule?.url else { return }
        webSiteRecipe(urlString: celluleRecipeUrl)
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataFunction()
        addShadowTexte(label: titleFavoriteDetailsLabel)
        configureRecipe()
        checkIfRecipeIsFavorite()
    }
    
    // MARK: - Privates
    private func coreDataFunction() {
        coreDataSetting = CoreDataSetting(coreDataStack: CoreDataStack(modelName: "Reciplease"))
    }
    
    private func configureRecipe() {
        guard let yield = cellule?.yield else { return }
        guard let time = cellule?.time else { return }
        
        titleFavoriteDetailsLabel.text = cellule?.title
        ingredientsFavoriteDetailsTextView.text = cellule?.ingredients
        yieldFavoriteLabel.text = String(yield)
        timeFavoriteLabel.text = Int(time).formatToStringTime
        FavoriteDetailsImageView.load(urlImageString: cellule?.image)
    }
    
    private func checkIfRecipeIsFavorite() {
        guard let recipeTitle = cellule?.title else { return }
        guard let url = cellule?.url else { return }
        guard let checkIsRecipeIsFavorite = coreDataSetting?.checkIfRecipeIsFavorite(recipeTitle: recipeTitle, url: url) else { return }
        recipeIsFavorite = checkIsRecipeIsFavorite
        if recipeIsFavorite {
            FavoritesButton.tintColor = UIColor.green
        } else {
            FavoritesButton.tintColor = .none
        }
    }
}
