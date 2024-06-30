//
//  URLCache+.swift
//  NetworkManagerPractice
//
//  Created by Jackie Lu on 2024/6/27.
//

import Foundation

extension URLCache {
    static let imageCache: URLCache = {
        URLCache(memoryCapacity: 20 * 1024 * 1024,
                 diskCapacity: 30 * 1024 * 1024,
                 directory: FileManager.default.temporaryDirectory)
    }()
}
