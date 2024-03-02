//
//  ListRecipesTableViewCell.swift
//  Reciplease
//
//  Created by Perveaux Nicolas on 27/02/2024.
//

import UIKit

class RecipesTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var grayView: UIView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleRecipeLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK: - View life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        customViewCell(view: recipeImageView)
        addShadowTexte(label: titleRecipeLabel )
        addShadowTexte(label: ingredientsLabel )
    }
    
    // MARK: - Properties
    var recipe: Recipe? {
        didSet {
            titleRecipeLabel.text = recipe?.label.localizedCapitalized
            ingredientsLabel.text = recipe?.ingredientLines.joined(separator: ", ")
            yieldLabel.text = String(recipe?.yield ?? 0)
            timeLabel.text = String((recipe?.totalTime ?? 0))
            recipeImageView.load(urlImageString: recipe?.image ?? "ImageDefault1024x768" + ".jpg")
        }
    }
}
