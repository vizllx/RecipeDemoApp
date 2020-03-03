//
//  RecipeAddViewModel.swift
//  RecipeDemoApp
//
//  Created by Sandeep Mukherjee on 03.03.20.
//  Copyright © 2020 Sandeep Mukherjee. All rights reserved.
//

import Foundation
import CoreData
import UIKit



protocol RecipeAddViewModelProtocol: class {

    func saveRecipes(recipeTitle:String?,recipeIngredients:String?,recipeSteps:String?,recipeCategory:String?,recipeImage:UIImage?)
     func getCategories() -> [Category]

}
protocol RecipeAddViewModelDelegate: class {
    func didLoadData()

}

class RecipeAddViewModel:RecipeAddViewModelProtocol {

    weak var delegate: RecipeAddViewModelDelegate?

    func getCategories() -> [Category]
    {
        if let recipeCategories =  RecipeCategories.retrieveLibrary()
        {
            return recipeCategories.categories
        }
        return []
    }

    func saveRecipes(recipeTitle:String?,recipeIngredients:String?,recipeSteps:String?,recipeCategory:String?,recipeImage:UIImage?){

        if  recipeTitle != "" {
            guard let app = UIApplication.shared.delegate as? AppDelegate  else {
                return
            }
            let context = app.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Recipes", in: context)!
            let recipe = Recipes(entity: entity, insertInto: context)

            recipe.title = recipeTitle
            recipe.ingredients = recipeIngredients
            recipe.steps = recipeSteps
            recipe.category = recipeCategory
            let data = recipeImage?.pngData()
            recipe.image = data  as Data?

            context.insert(recipe)
            do {
                try context.save()
            } catch {
                print("could not save")
            }
        }
    }

}
