//
//  CatAPIManager.swift
//  NetworkManagerPractice
//
//  Created by Jackie Lu on 2024/6/26.
//

import Foundation

@MainActor
final class CatAPIManager: ObservableObject {
    @Published private(set) var favorites: [FavoriteItem] = [] 
    var getData: (Endpoint) async throws -> Data

    init(getData: @escaping (Endpoint) async throws -> Data) {
        self.getData = getData
    }
}

// MARK: singleton
extension CatAPIManager {
    
    static let shared = {
        let config = URLSessionConfiguration.default
        var headers = config.httpAdditionalHeaders ?? [:]
        headers["x-api-key"] = MySecret.apiKey
        config.httpAdditionalHeaders = headers

        let session = URLSession(configuration: config)
        return CatAPIManager { try await session.data(for: $0.request) }
    }()
    
    static let preview = CatAPIManager {
        try? await Task.sleep(for: .seconds(1))
        return $0.stub
    }
}

// MARK: interface
extension CatAPIManager {
    func getImages() async throws -> [ImageResponse] {
        try await fetch(endpoint: .images)
    }
    
    func getFavorites() async throws {
        favorites = try await fetch(endpoint: .favorites)
    }
    
    func toggleFavorite(_ cat: CatImageViewModel) async throws {
        guard let index = favorites.firstIndex(where: \.imageID == cat.id)  else {
            try await addToFavorite(cat: cat)
            return
        }
        try await removeFromFavorite(at: index)
        
    }
    
    func addToFavorite(cat: CatImageViewModel) async throws {
        let body = ["image_id": cat.id]
        let bodyData = try JSONSerialization.data(withJSONObject: body)
        let response: FavoriteCreationResponse = try await fetch(endpoint: .addToFavorite(bodyData: bodyData))
        
        favorites.append(.init(catImage: cat, id: response.id))
    }
    
    func removeFromFavorite(id: Int) async throws {
        do {
            let _ = try await getData(.removeFromFavorite(id: id))
            guard let index = favorites.firstIndex(where: \.id == id) else { return }
            favorites.remove(at: index)
        } catch URLSession.APIError.invalidCode(400) {
            // 不存在的最愛 ID
        }
    }
}


// MARK: helper
private extension CatAPIManager {
    nonisolated func fetch<T: Decodable>(endpoint: Endpoint) async throws -> T {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let data = try await getData(endpoint)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return try decoder.decode(T.self, from: data)
    }
    
    func removeFromFavorite(at index: Int) async throws {
        do {
            let _ = try await getData(.removeFromFavorite(id: favorites[index].id))
            favorites.remove(at: index)
        } catch URLSession.APIError.invalidCode(400) {
            // 不存在的最愛 ID
        }
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
}


extension CatAPIManager {
    enum Endpoint {
        case images
        case addToFavorite(bodyData: Data)
        case favorites
        case removeFromFavorite(id: Int)
        
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
            case .removeFromFavorite(id: let id):
                var urlRequest = URLRequest(url: URL(string: "https://api.thecatapi.com/v1/favourites/\(id)")!)
                urlRequest.httpMethod = "DELETE"
                return urlRequest
            }
        }
    }
}
