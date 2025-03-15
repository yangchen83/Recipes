//
//  RecipeServiceTests.swift
//  RecipesTests
//
//  Created by Yang Chen on 3/14/25.
//

import Testing
@testable import Recipes

struct RecipeServiceTests {
    @Test
    func testNonEmptyResponse() async {
        let service = RecipeService()
        
        await #expect(throws: Never.self) {
            let recipes = try await service.fetchRecipes()
            
            #expect(!recipes.isEmpty)
        }
    }
    
    @Test
    func testEmptyResponse() async {
        let service = RecipeService(urlString: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")
        
        await #expect(throws: Never.self) {
            let recipes = try await service.fetchRecipes()
            
            #expect(recipes.isEmpty)
        }
    }
    
    @Test
    func testMalformedResponse() async {
        let service = RecipeService(urlString: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")
        
        await #expect(throws: (any Error).self) {
            _ = try await service.fetchRecipes()
        }
    }
}
