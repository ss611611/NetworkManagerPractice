//
//  CatAPIManager.swift
//  NetworkManagerPractice
//
//  Created by Jackie Lu on 2024/6/26.
//

import Foundation

final class CatAPIManager {
    var getData: (Endpoint) async throws -> Data
    
    static let shared = {
        let config = URLSessionConfiguration.default
        var headers = config.httpAdditionalHeaders ?? [:]
        headers["x-api-key"] = MySecret.apiKey
        config.httpAdditionalHeaders = headers

        let session = URLSession(configuration: config)
        return CatAPIManager { try await session.data(for: $0.request) }
    }()
    
    static let stub = CatAPIManager { $0.stub }
    
    private init(getData: @escaping (Endpoint) async throws -> Data) {
        self.getData = getData
    }
}

extension CatAPIManager {
    func getImages() async throws -> [ImageResponse] {
        try await fetch(endpoint: .images)
    }
    
    func getFavorites() async throws -> [FavoriteResponse]{
        try await fetch(endpoint: .favorites)
    }
    
    func addToFavorite(imageID: String) async throws -> Int {
        let body = ["image_id": imageID]
        let bodyData = try JSONSerialization.data(withJSONObject: body)
        let response: FavoriteCreationResponse = try await fetch(endpoint: .addToFavorite(bodyData: bodyData))
        
        return response.id
    }
}

private extension CatAPIManager {
    func fetch<T: Decodable>(endpoint: Endpoint) async throws -> T {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let data = try await getData(endpoint)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return try decoder.decode(T.self, from: data)
    }
}

extension CatAPIManager {
    struct ImageResponse: Decodable {
        let id: String
        let url: URL
        let width, height: CGFloat
    }
    
    struct FavoriteCreationResponse: Decodable {
        let id: Int
    }
    
    struct FavoriteResponse: Decodable {
        let id: Int
        let imageID: String
        let createdAt: Date
        let imageURL: URL

        enum CodingKeys: String, CodingKey {
            case id
            case imageID = "image_id"
            case createdAt = "created_at"
            case image
        }
        
        enum ImageCodingKeys: String, CodingKey {
            case url
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(Int.self, forKey: .id)
            self.imageID = try container.decode(String.self, forKey: .imageID)
            self.createdAt = try container.decode(Date.self, forKey: .createdAt)
            
            let imageContainer = try container.nestedContainer(keyedBy: ImageCodingKeys.self, forKey: .image)
            self.imageURL = try imageContainer.decode(URL.self, forKey: .url)
        }
    }
}


extension CatAPIManager {
    enum Endpoint {
        case images
        case addToFavorite(bodyData: Data)
        case favorites
        
        var request: URLRequest {
            switch self {
            case .images:
                return URLRequest(url: "https://api.thecatapi.com/v1/images/search?limit=10")
            case .addToFavorite(let bodyData):
                var urlRequest = URLRequest(url: "https://api.thecatapi.com/v1/favourites")
                urlRequest.httpMethod = "POST"
                urlRequest.httpBody = bodyData
                urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                
                return urlRequest
            case .favorites:
                // TODO: 新增頁面參數
                return URLRequest(url: "https://api.thecatapi.com/v1/favourites")
            }
        }
    }
}
