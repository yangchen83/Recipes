//
//  RecipesApp.swift
//  Recipes
//
//  Created by Yang Chen on 3/14/25.
//

import SwiftUI

@main
struct RecipesApp: App {
    var body: some Scene {
        WindowGroup {
            RecipeListView(viewModel: .init())
        }
    }
}
