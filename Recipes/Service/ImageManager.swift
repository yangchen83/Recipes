//
//  ImageManager.swift
//  Recipes
//
//  Created by Yang Chen on 3/15/25.
//

import Foundation
import UIKit

enum ImageManagerError: Error {
    case invalidData
}

class ImageManager {
    private let cacher: ImageCacher
    private let service: DataFetchable
    
    init(cacher: ImageCacher = ImageDiskCacher.sharedInstance, service: DataFetchable = DataService()) {
        self.cacher = cacher
        self.service = service
    }
}

extension ImageManager {
    func fetchImage(from url: URL) async throws -> UIImage {
        if let data = await cacher.getCachedData(for: url), let image = UIImage(data: data) {
            return image
        }
        
        let data = try await service.fetchData(from: url)
        guard let image = UIImage(data: data) else {
            throw ImageManagerError.invalidData
        }

        await cacher.cache(data, for: url)

        return image
    }
}
