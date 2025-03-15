//
//  Recipe.swift
//  Recipes
//
//  Created by Yang Chen on 3/14/25.
//

import Foundation

class Recipe: Codable {
    let uuid: String
    let name: String
    let cuisine: String
    let photoUrlSmall: String?
    let photoUrlLarge: String?
    let sourceUrl: String?
    let youtubeUrl: String?
    
    init(
        uuid: String,
        name: String,
        cuisine: String,
        photoUrlSmall: String?,
        photoUrlLarge: String?,
        sourceUrl: String?,
        youtubeUrl: String?
    ) {
        self.uuid = uuid
        self.name = name
        self.cuisine = cuisine
        self.photoUrlSmall = photoUrlSmall
        self.photoUrlLarge = photoUrlLarge
        self.sourceUrl = sourceUrl
        self.youtubeUrl = youtubeUrl
    }
}

extension Recipe {
    var smallPhotoUrl: URL? {
        return photoUrlSmall.flatMap { URL(string: $0) }
    }
    
    var largePhotoUrl: URL? {
        return photoUrlLarge.flatMap { URL(string: $0) }
    }
    
    var sourceWebUrl: URL? {
        return sourceUrl.flatMap { URL(string: $0) }
    }
    
    var youtubeWebUrl: URL? {
        return youtubeUrl.flatMap { URL(string: $0) }
    }
}

// MARK: - Identifiable

extension Recipe: Identifiable {
    var id: String {
        return uuid
    }
}

extension Recipe {
    static var mockRecipe: Recipe {
        return .init(
            uuid: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
            name: "Apam Balik",
            cuisine: "Malaysian",
            photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
            photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
            sourceUrl: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
            youtubeUrl: "https://www.youtube.com/watch?v=6R8ffRRJcrg"
        )
    }
}
