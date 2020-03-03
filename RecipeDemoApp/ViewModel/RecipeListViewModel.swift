//
//  RecipeListViewModel.swift
//  RecipeDemoApp
//
//  Created by Sandeep Mukherjee on 03.03.20.
//  Copyright © 2020 Sandeep Mukherjee. All rights reserved.
//

import Foundation
import CoreData
import UIKit



protocol RecipeListViewModelProtocol: class {

    func fetchRecipes()

}
protocol RecipeListViewModelDelegate: class {
    func didLoadData()

}

class RecipeListViewModel:RecipeListViewModelProtocol {
    weak var delegate: RecipeListViewModelDelegate?
    var recipes = [Recipes]()


    func fetchRecipes(){
        guard let app = UIApplication.shared.delegate as? AppDelegate  else {
            return
        }
        let context = app.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Recipes")
        do {
            let results = try context.fetch(fetchRequest)
            self.recipes = results as! [Recipes]
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }

}
