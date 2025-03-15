//
//  RecipeView.swift
//  Recipes
//
//  Created by Yang Chen on 3/14/25.
//

import SwiftUI

struct RecipeView: View {
    let recipe: Recipe

    var body: some View {
        HStack {
            if let url = recipe.smallPhotoUrl {
                AsyncCachedImage(url: url) { phase in
                    if case .success(let image) = phase {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                            .padding(2)
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                    else {
                        placeholderView
                    }
                }
            }
            else {
                placeholderView
            }
            
            VStack(alignment: .leading, spacing: 6.0) {
                Text(recipe.name)
                    .font(.title2)
                    .foregroundStyle(.primary)
                
                Text(recipe.cuisine)
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 12.0)
                    .padding(.vertical, 4.0)
                    .background(Color.black)
                    .cornerRadius(10.0)
            }
        }
    }
}

private extension RecipeView {
    var placeholderView: some View {
        Image(systemName: "list.bullet.rectangle.portrait")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
    }
}

#Preview {
    RecipeView(recipe: .mockRecipe)
}
