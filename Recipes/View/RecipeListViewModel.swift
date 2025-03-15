//
//  RecipeListViewModel.swift
//  Recipes
//
//  Created by Yang Chen on 3/14/25.
//

import Foundation

enum RecipeListMode {
    case loading
    case content([Recipe])
    case error
    
    var hasContent: Bool {
        return switch self {
        case .content(let recipes):
            !recipes.isEmpty
        default:
            false
        }
    }
}

@MainActor
class RecipeListViewModel: ObservableObject {
    static let allCuisinesName = NSLocalizedString("RECIPE_LIST_ALL_CUISINES", comment: "")

    private let recipeService: RecipeService
    private(set) var hasLoadedInitialData: Bool = false
    @Published private(set) var mode: RecipeListMode = .content([])
    @Published private(set) var cuisines: [String]

    init(recipeService: RecipeService = .init()) {
        self.recipeService = recipeService
        cuisines = [Self.allCuisinesName]
    }
}

extension RecipeListViewModel {
    func fetchRecipes() async {
        if !mode.hasContent {
            mode = .loading
        }
        
        do {
            let recipes = try await RecipeService().fetchRecipes()
            mode = .content(recipes)
            let cuisinesSet = Set(recipes.map { $0.cuisine })
            var cuisines = Array(cuisinesSet).sorted()
            cuisines.insert(Self.allCuisinesName, at: 0)
            self.cuisines = cuisines
        } catch {
            mode = .error
        }

        hasLoadedInitialData = true
    }
}
