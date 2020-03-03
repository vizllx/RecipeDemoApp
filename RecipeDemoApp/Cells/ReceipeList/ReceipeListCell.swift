//
//  ReceipeListCell.swift
//  RecipeDemoApp
//
//  Created by Sandeep Mukherjee on 03.03.20.
//  Copyright © 2020 Sandeep Mukherjee. All rights reserved.
//

import UIKit

class ReceipeListCell: UITableViewCell {

    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(recipe: Recipes) {
        recipeTitle.text = recipe.title
        if let image = recipe.image
        {
            recipeImage.image = UIImage(data:image)
        }
        recipeImage.clipsToBounds = true
        recipeImage.contentMode = .scaleAspectFill
    }
    
}
