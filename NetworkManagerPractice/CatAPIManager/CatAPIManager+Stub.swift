//
//  CatAPIManager+Stub.swift
//  NetworkManagerPractice
//
//  Created by Jackie Lu on 2024/6/27.
//

import Foundation

extension CatAPIManager.Endpoint {
    var stub: Data {
        let string: String
        switch self {
        case .images:
            string = """
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
"""
        case .addToFavorite:
            string = """
{
    "id":100038507
}
"""
        case .favorites:
            string = """
[{
"id":100038507,
"image_id":"E8dL1Pqpz",
"sub_id":null,
"created_at":"2022-07-10T12:24:39.000Z",
"image":{
    "id":"E8dL1Pqpz",
    "url":"https://cdn2.thecatapi.com/images/E8dL1Pqpz.jpg"
    }
}]
"""
        }
        
        return Data(string.utf8)
    }
}
