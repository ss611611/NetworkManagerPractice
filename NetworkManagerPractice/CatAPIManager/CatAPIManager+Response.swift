//
//  CatAPIManager+Response.swift
//  NetworkManagerPractice
//
//  Created by Jackie Lu on 2024/6/29.
//

import Foundation

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
