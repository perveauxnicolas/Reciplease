//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by Perveaux Nicolas on 20/02/2024.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var grayViewDetails: UIView!
    @IBOutlet weak var recipeDetailsImageView: UIImageView!
    @IBOutlet weak var yieldDetailsLabel: UILabel!
    @IBOutlet weak var timeDetailsLabel: UILabel!
    @IBOutlet weak var titleRecipeDetailsLabel: UILabel!
    @IBOutlet weak var ingredientsDetailsTextView: UITextView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var instructionsButton: UIButton!
    
    // MARK: - Properties
    var cellule: Hit?

    // MARK: - Methods
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadowTexte(label: titleRecipeDetailsLabel)
        configureRecipe()
    }
    
    // MARK: - Actions
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
    }
    @IBAction func instructionsButtonTapped(_ sender: UIButton) {
    }

    // MARK: - Privates
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
    
    
}
