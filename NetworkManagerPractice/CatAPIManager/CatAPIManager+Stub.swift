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
[{"id":101329412,"user_id":"tpxmop","image_id":"4sb","sub_id":null,"created_at":"2023-04-18T03:25:53.000Z","image":{"id":"4sb","url":"https://cdn2.thecatapi.com/images/4sb.jpg"}},{"id":101329439,"user_id":"tpxmop","image_id":"aef","sub_id":null,"created_at":"2023-04-18T05:07:47.000Z","image":{"id":"aef","url":"https://cdn2.thecatapi.com/images/aef.jpg"}},{"id":101329440,"user_id":"tpxmop","image_id":"gd","sub_id":null,"created_at":"2023-04-18T05:09:45.000Z","image":{"id":"gd","url":"https://cdn2.thecatapi.com/images/gd.jpg"}},{"id":101329442,"user_id":"tpxmop","image_id":"125","sub_id":null,"created_at":"2023-04-18T05:13:27.000Z","image":{"id":"125","url":"https://cdn2.thecatapi.com/images/125.jpg"}},{"id":232343132,"user_id":"tpxmop","image_id":"4en","sub_id":null,"created_at":"2023-05-24T02:45:08.000Z","image":{"id":"4en","url":"https://cdn2.thecatapi.com/images/4en.jpg"}},{"id":232343133,"user_id":"tpxmop","image_id":"beh","sub_id":null,"created_at":"2023-05-24T02:45:15.000Z","image":{"id":"beh","url":"https://cdn2.thecatapi.com/images/beh.jpg"}},{"id":232343134,"user_id":"tpxmop","image_id":"cqk","sub_id":null,"created_at":"2023-05-24T02:45:18.000Z","image":{"id":"cqk","url":"https://cdn2.thecatapi.com/images/cqk.jpg"}},{"id":232343135,"user_id":"tpxmop","image_id":"9jg","sub_id":null,"created_at":"2023-05-24T02:45:59.000Z","image":{"id":"9jg","url":"https://cdn2.thecatapi.com/images/9jg.jpg"}},{"id":232343136,"user_id":"tpxmop","image_id":"e54","sub_id":null,"created_at":"2023-05-24T02:46:25.000Z","image":{"id":"e54","url":"https://cdn2.thecatapi.com/images/e54.jpg"}},{"id":232343137,"user_id":"tpxmop","image_id":"MTUyNTM3Nw","sub_id":null,"created_at":"2023-05-24T02:46:29.000Z","image":{"id":"MTUyNTM3Nw","url":"https://cdn2.thecatapi.com/images/MTUyNTM3Nw.jpg"}},{"id":232343138,"user_id":"tpxmop","image_id":"UrYSVFQZo","sub_id":null,"created_at":"2023-05-24T02:46:36.000Z","image":{"id":"UrYSVFQZo","url":"https://cdn2.thecatapi.com/images/UrYSVFQZo.jpg"}},{"id":232343139,"user_id":"tpxmop","image_id":"9g5","sub_id":null,"created_at":"2023-05-24T02:46:46.000Z","image":{"id":"9g5","url":"https://cdn2.thecatapi.com/images/9g5.jpg"}},{"id":232343140,"user_id":"tpxmop","image_id":"6mt","sub_id":null,"created_at":"2023-05-24T02:52:38.000Z","image":{"id":"6mt","url":"https://cdn2.thecatapi.com/images/6mt.jpg"}}]
"""
        case .removeFromFavorite:
            string = ""
        }
        
        return Data(string.utf8)
    }
}
