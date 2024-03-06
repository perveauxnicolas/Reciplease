//
//  RecipeListViewController.swift
//  Reciplease
//
//  Created by Perveaux Nicolas on 20/02/2024.
//

import UIKit

final class RecipeListViewController: UIViewController {
    
    // MARK: - Properties
    var recipesList = [Hit]()
    private var cellSelected: Hit?
    private let ListRecipesCell = "ListRecipesCell"
    private let segueToRecipeDetail = "segueToRecipeDetail"
    
    // MARK: - Outlets
    @IBOutlet weak var recipesTableView: UITableView!
    
    // MARK: - View life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recipesTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension RecipeListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  recipesList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listRecipesCell = tableView.dequeueReusableCell(withIdentifier: ListRecipesCell, for: indexPath) as? RecipesTableViewCell
        else {
            return UITableViewCell()
        }
        let recipe = recipesList[indexPath.row]
        listRecipesCell.recipe = recipe.recipe
        return listRecipesCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.cellSelected = recipesList[indexPath.row]
        performSegue(withIdentifier: self.segueToRecipeDetail, sender: self)
    }
}

extension RecipeListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToRecipeDetail {
            guard let detailRecipeVC = segue.destination as? RecipeDetailViewController else { return }
            detailRecipeVC.cellule = self.cellSelected
        }
    }
}
