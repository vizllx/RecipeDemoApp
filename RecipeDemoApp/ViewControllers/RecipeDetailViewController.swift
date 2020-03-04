//
//  RecipeDetailViewController.swift
//  RecipeDemoApp
//
//  Created by Sandeep Mukherjee on 03.03.20.
//  Copyright © 2020 Sandeep Mukherjee. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {


    @IBOutlet weak var recipeIngredients: UILabel!
    @IBOutlet weak var recipeSteps: UILabel!
    @IBOutlet weak var recipeCategory: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    internal var recipes: Recipes?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()

        // Do any additional setup after loading the view.
    }

    fileprivate func setupView()
    {
        self.recipeIngredients.text = recipes?.ingredients
        self.recipeSteps.text = recipes?.steps
        self.recipeCategory.text = recipes?.category
        if let image = recipes?.image
        {
            recipeImage.image = UIImage(data:image)
        }

    }

    @IBAction func rightBarButtonAction(_ sender: Any) {

        guard let recipeAddViewController = storyboard?.instantiateViewController(withIdentifier: "RecipeAddViewController") as? RecipeAddViewController else { return }
        recipeAddViewController.recipes = recipes
        navigationController?.pushViewController(recipeAddViewController, animated: true)


    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
