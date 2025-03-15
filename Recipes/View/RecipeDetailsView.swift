//
//  RecipeDetailsView.swift
//  Recipes
//
//  Created by Yang Chen on 3/14/25.
//

import SwiftUI

struct RecipeDetailsView: View {
    let recipe: Recipe
    @Environment(\.openURL) private var openURL

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                RecipeView(recipe: recipe)
                
                Spacer()
            }
            
            if let sourceWebUrl = recipe.sourceWebUrl {
                Button {
                    openURL(sourceWebUrl)
                } label: {
                    Text("RECIPE_DETAILS_VIEW_SOURCE")
                        .font(.title3)
                        .bold()
                        .padding()
                }
            }
            
            if let youtubeWebUrl = recipe.youtubeWebUrl {
                Button {
                    openURL(youtubeWebUrl)
                } label: {
                    Text("RECIPE_DETAILS_VIEW_YOUTUBE")
                        .font(.title3)
                        .bold()
                        .padding()
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    RecipeDetailsView(recipe: .mockRecipe)
}
