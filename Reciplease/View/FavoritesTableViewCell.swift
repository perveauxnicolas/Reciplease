//
//  FavoritesTableViewCell.swift
//  Reciplease
//
//  Created by Perveaux Nicolas on 04/03/2024.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var FavoriteImageView: UIImageView!
    @IBOutlet weak var titleFavoriteLabel: UILabel!
    @IBOutlet weak var ingredientsFavoriteLabel: UILabel!
    @IBOutlet weak var yieldFavoriteLabel: UILabel!
    @IBOutlet weak var timeFavoriteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customViewCell(view: FavoriteImageView)
        addShadowTexte(label: titleFavoriteLabel )
        addShadowTexte(label: ingredientsFavoriteLabel )
    }
    // MARK: - Properties
    var recipeEntity: RecipeEntity? {
        didSet {
            titleFavoriteLabel.text = recipeEntity?.title
            ingredientsFavoriteLabel.text = recipeEntity?.ingredients
            yieldFavoriteLabel.text = String(recipeEntity?.yield ?? 0)
            timeFavoriteLabel.text = Int(recipeEntity?.time ?? 0).formatToStringTime
            FavoriteImageView.load(urlImageString: recipeEntity?.image ?? "ImageDefault1024x768" + ".jpg")
        }
    }
}
