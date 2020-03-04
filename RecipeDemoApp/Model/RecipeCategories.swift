//
//  Categories.swift
//  RecipeDemoApp
//
//  Created by Sandeep Mukherjee on 03.03.20.
//  Copyright © 2020 Sandeep Mukherjee. All rights reserved.
//

import Foundation
struct RecipeCategories: Codable {
    var categories: [Category]
    enum CodingKeys: String, CodingKey {
        case categories = "category"
    }
}

struct Category: Codable {
    var id: String
    var name: String
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}

extension RecipeCategories {
    static func retrieveLibrary() -> RecipeCategories? {
        let xmlPath = Bundle.main.path(forResource: "RecipeTypes", ofType: "xml")
        guard let data = NSData(contentsOfFile: xmlPath!) else { return nil }
        let decoder = XMLDecoder()
        let categories: RecipeCategories?
        do {
            categories = try decoder.decode(RecipeCategories.self, from: data as Data)
        } catch {
            print(error)
            categories = nil
        }
        return categories
    }
}
