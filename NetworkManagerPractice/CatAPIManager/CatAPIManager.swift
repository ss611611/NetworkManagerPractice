//
//  CatAPIManager.swift
//  NetworkManagerPractice
//
//  Created by Jackie Lu on 2024/6/26.
//

import Foundation

final class CatAPIManager {
    var getData: (URLRequest) async throws -> Data
    
    static let shared = {
        let session = URLSession(configuration: .default)
        return CatAPIManager(getData: session.data)
    }()
    
    static let stub = CatAPIManager { _ in
        return Data("""
[
  {
    "id": "1gd",
    "url": "https://cdn2.thecatapi.com/images/1gd.png",
    "width": 640,
    "height": 480
  },
  {
    "id": "5fj",
    "url": "https://cdn2.thecatapi.com/images/5fj.jpg",
    "width": 500,
    "height": 375
  },
  {
    "id": "9cu",
    "url": "https://cdn2.thecatapi.com/images/9cu.jpg",
    "width": 640,
    "height": 480
  },
  {
    "id": "b0o",
    "url": "https://cdn2.thecatapi.com/images/b0o.jpg",
    "width": 500,
    "height": 333
  },
  {
    "id": "bgc",
    "url": "https://cdn2.thecatapi.com/images/bgc.png",
    "width": 500,
    "height": 373
  },
  {
    "id": "e20",
    "url": "https://cdn2.thecatapi.com/images/e20.jpg",
    "width": 600,
    "height": 450
  },
  {
    "id": "ecd",
    "url": "https://cdn2.thecatapi.com/images/ecd.jpg",
    "width": 400,
    "height": 267
  },
  {
    "id": "MTU1NzE4MQ",
    "url": "https://cdn2.thecatapi.com/images/MTU1NzE4MQ.jpg",
    "width": 640,
    "height": 480
  },
  {
    "id": "MTU1NzgzOQ",
    "url": "https://cdn2.thecatapi.com/images/MTU1NzgzOQ.jpg",
    "width": 448,
    "height": 600
  },
  {
    "id": "MjA4NjA3Nw",
    "url": "https://cdn2.thecatapi.com/images/MjA4NjA3Nw.jpg",
    "width": 640,
    "height": 567
  }
]
""".utf8)
    }
    
    private init(getData: @escaping (URLRequest) async throws -> Data) {
        self.getData = getData
    }
}

extension CatAPIManager {
    func getImages() async throws -> [ImageResponse] {
        let data = try await getData(URLRequest(url: "https://api.thecatapi.com/v1/images/search?limit=10"))
        return try JSONDecoder().decode([ImageResponse].self, from: data)
    }
}

extension CatAPIManager {
    struct ImageResponse: Decodable {
        let id: String
        let url: URL
        let width, height: CGFloat
    }
}
