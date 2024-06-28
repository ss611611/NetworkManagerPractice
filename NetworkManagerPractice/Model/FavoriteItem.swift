//
//  FavoriteItem.swift
//  NetworkManagerPractice
//
//  Created by Jackie Lu on 2024/6/27.
//

import Foundation

struct FavoriteItem: Decodable {
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
    
    init(catImage: CatImageViewModel, id: Int) {
        self.id = id
        self.imageID = catImage.id
        self.createdAt = .now
        self.imageURL = catImage.url
    }
}

extension FavoriteItem: Equatable { }
