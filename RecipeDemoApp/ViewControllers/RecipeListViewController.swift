//
//  RecipeListViewController.swift
//  RecipeDemoApp
//
//  Created by Sandeep Mukherjee on 03.03.20.
//  Copyright © 2020 Sandeep Mukherjee. All rights reserved.
//

import UIKit

class RecipeListViewController: UIViewController, UITableViewDataSource  {


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

}

// MARK: - UITableViewDelegate
extension RecipeListViewController: UITableViewDelegate
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
}

