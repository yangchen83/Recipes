//
//  DataService.swift
//  Recipes
//
//  Created by Yang Chen on 3/14/25.
//

import Foundation
import UIKit

protocol DataFetchable {
    func fetchData(from url: URL) async throws -> Data
}

class DataService: DataFetchable {
    private let cacher = ImageDiskCacher.sharedInstance
}

extension DataService {
    func fetchData(from url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        return data
    }
}
