//
//  FavoriteListViewController.swift
//  Reciplease
//
//  Created by Perveaux Nicolas on 21/02/2024.
//

import UIKit

final class FavoriteListViewController: UIViewController {
    
    // MARK: - Properties
    private var coreDataSetting: CoreDataSetting?
    private var cellSelected: RecipeEntity?
    private let ListFavoriteCell = "ListFavoriteCell"
    private let segueToRecipeDetailFavorite = "segueToRecipeDetailFavorite"
    
    // MARK: - Outlets
    @IBOutlet weak var favoritesRecipesTableView: UITableView!

    
    // MARK: - View life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesRecipesTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataFunction()
    }
    
    @IBAction func ResetButton(_ sender: UIBarButtonItem) {
        coreDataSetting?.deleteAllRecipes()
        favoritesRecipesTableView.reloadData()
    }
    
    // MARK: - Privates
    private  func coreDataFunction() {
        coreDataSetting = CoreDataSetting(coreDataStack: CoreDataStack(modelName: "Reciplease"))
    }
}

// MARK: - UITableViewDataSource
extension FavoriteListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataSetting?.recipes.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listRecipesCell = tableView.dequeueReusableCell(
            withIdentifier: ListFavoriteCell,
            for: indexPath) as? FavoritesTableViewCell else {
            return UITableViewCell()
        }
        let recipe = coreDataSetting?.recipes[indexPath.row]
        listRecipesCell.recipeEntity = recipe
        return listRecipesCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.cellSelected = coreDataSetting?.recipes[indexPath.row]
        performSegue(withIdentifier: self.segueToRecipeDetailFavorite, sender: self)
    }
}

// MARK: - UITableViewDelegate
extension FavoriteListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Click on the star to add the recipe in your favorites"
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }
}

// MARK: - Navigation
extension FavoriteListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToRecipeDetailFavorite {
            guard let detailFavoritesRecipesVC = segue.destination
                    as? FavoriteViewController else { return }
            detailFavoritesRecipesVC.cellule = self.cellSelected
        }
    }
}
