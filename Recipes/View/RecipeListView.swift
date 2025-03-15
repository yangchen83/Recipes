//
//  ContentView.swift
//  Recipes
//
//  Created by Yang Chen on 3/14/25.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject var viewModel: RecipeListViewModel
    @State var selectedCuisine: String = RecipeListViewModel.allCuisinesName

    var body : some View {
        NavigationStack {
            Group {
                switch viewModel.mode {
                case .loading:
                    ProgressView()

                case .content(let recipes):
                    listView(for: recipes)

                case .error:
                    errorView
                }
            }
            .navigationTitle("RECIPE_LIST_TITLE")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    cuisinePicker
                }
            }
            .refreshable {
                await viewModel.fetchRecipes()
            }
            .task {
                guard !viewModel.hasLoadedInitialData else {
                    return
                }

                await viewModel.fetchRecipes()
            }
        }
    }
}

private extension RecipeListView {
    var errorView: some View {
        VStack(spacing: 8) {
            Text("RECIPE_LIST_ERROR_MESSAGE")
            Button("RECIPE_LIST_RETRY") {
                Task {
                    await viewModel.fetchRecipes()
                }
            }
        }
    }

    func listView(for recipes: [Recipe]) -> some View {
        let filteredRecipes = if selectedCuisine == RecipeListViewModel.allCuisinesName {
            recipes
        }
        else {
            recipes.filter { $0.cuisine == selectedCuisine }
        }

        return Group {
            if filteredRecipes.isEmpty {
                Text("RECIPE_LIST_EMPTY")
            }
            else {
                List(filteredRecipes) { recipe in
                    NavigationLink {
                        RecipeDetailsView(recipe: recipe)
                            .navigationTitle(recipe.name)
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        RecipeView(recipe: recipe)
                   }
                }
            }
        }
    }

    var cuisinePicker: some View {
        Picker(selectedCuisine, selection: $selectedCuisine) {
            ForEach(viewModel.cuisines, id: \.self) {
                Text($0)
            }
        }
    }
}

#Preview {
    RecipeListView(viewModel: .init())
}
