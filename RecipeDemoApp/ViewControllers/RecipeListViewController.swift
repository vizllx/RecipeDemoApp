//
//  RecipeListViewController.swift
//  RecipeDemoApp
//
//  Created by Sandeep Mukherjee on 03.03.20.
//  Copyright © 2020 Sandeep Mukherjee. All rights reserved.
//

import UIKit

class RecipeListViewController: UIViewController  {


    // MARK: - Properties
    fileprivate var viewModel: RecipeListViewModel? = RecipeListViewModel()
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "ReceipeListCell", bundle: nil), forCellReuseIdentifier: "ReceipeListCell")


        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel?.fetchRecipes()
        tableView.reloadData()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailSegue") {
            let recipeDetailViewController = segue.destination as? RecipeDetailViewController
            if let row = (sender as? IndexPath)?.row, let recipe = viewModel?.recipes[row] {
                recipeDetailViewController?.recipes = recipe
            }
        }
    }

}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension RecipeListViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        (viewModel?.recipes.count)! 
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ReceipeListCell") as? ReceipeListCell {
            if let recipe = viewModel?.recipes[indexPath.row]  {
                cell.configureCell(recipe: recipe)
            }
            return cell
        }else {
            return ReceipeListCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailSegue", sender: indexPath)

    }

}

