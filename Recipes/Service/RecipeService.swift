//
//  RecipeService.swift
//  Recipes
//
//  Created by Yang Chen on 3/14/25.
//

import Foundation

class RecipeService {
    private let urlString: String
    
    init(urlString: String = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") {
        self.urlString = urlString
    }
}

extension RecipeService {
    func fetchRecipes() async throws -> [Recipe] {
        guard let url else {
            return []
        }

        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        
        let list = try decoder.decode(RecipesList.self, from: data)
        return list.recipes
    }
}

private extension RecipeService {
    var url: URL? {
        return URL(string: urlString)
    }

    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return decoder
    }
}
