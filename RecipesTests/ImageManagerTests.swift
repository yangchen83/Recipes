//
//  ImageManagerTests.swift
//  Recipes
//
//  Created by Yang Chen on 3/15/25.
//

import Foundation
import Testing
@testable import Recipes

class ImageManagerTests: TestDataGettable {
    @Test
    func testFetchImage() async {
        let cacher = MockCaher()
        let service = MockDataService()
        let manager = ImageManager(cacher: cacher, service: service)
        
        guard let url = URL(string: "https://test.com") else {
            return
        }

        await confirmation(expectedCount: 1) { increaseCount in
            service.fetchDataHandler = {
                increaseCount()
            }
            
            _ = try? await manager.fetchImage(from: url)
        }
        
        #expect(cacher.cache.object(forKey: url.absoluteString as NSString) != nil)
        
        await confirmation(expectedCount: 0) { increaseCount in
            service.fetchDataHandler = {
                increaseCount()
            }
            
            _ = try? await manager.fetchImage(from: url)
        }
    }
}

class MockCaher: ImageCacher {
    private(set) var cache = NSCache<NSString, NSData>()

    func cache(_ data: Data, for url: URL) async {
        cache.setObject(data as NSData, forKey: url.absoluteString as NSString)
    }
    
    func getCachedData(for url: URL) async -> Data? {
        return cache.object(forKey: url.absoluteString as NSString) as? Data
    }
}

class MockDataService: DataFetchable, TestDataGettable {
    var fetchDataHandler: (() -> Void)?

    func fetchData(from url: URL) async throws -> Data {
        fetchDataHandler?()

        guard let testData else {
            throw NSError()
        }
        
        return testData
    }
}

protocol TestDataGettable: AnyObject {
    var testData: Data? { get }
}

extension TestDataGettable {
    var testData: Data? {
        let bundle = Bundle(for: type(of: self))
        
        guard let fileUrl = bundle.url(forResource: "test-image", withExtension: "jpg"),
        let data = try? Data(contentsOf: fileUrl) else {
            return nil
        }
        
        return data
    }
}
