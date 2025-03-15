//
//  ImageCacher.swift
//  Recipes
//
//  Created by Yang Chen on 3/14/25.
//

import Foundation
import UIKit

protocol ImageCacher {
    func cache(_ data: Data, for url: URL) async
    func getCachedData(for url: URL) async -> Data?
}

actor ImageDiskCacher {
    static let sharedInstance = ImageDiskCacher()
    
    private init() {}
}

extension ImageDiskCacher: ImageCacher {
    func cache(_ data: Data, for url: URL) {
        guard let folderURL else {
            return
        }

        try? data.write(to: folderURL.appendingPathComponent(url.fileName))
    }
    
    func getCachedData(for url: URL) -> Data? {
        guard let folderURL else {
            return nil
        }
        
        let fileURL = folderURL.appendingPathComponent(url.fileName)
        guard let data = try? Data(contentsOf: fileURL) else {
            return nil
        }

        return data
    }
}

private extension ImageDiskCacher {
    var folderURL: URL? {
        return FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first
    }
}

private extension URL {
    var fileName: String {
        return absoluteString.replacingOccurrences(of: "/", with: "")
    }
}
