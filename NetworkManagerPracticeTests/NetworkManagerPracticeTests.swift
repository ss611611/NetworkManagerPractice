//
//  NetworkManagerPracticeTests.swift
//  NetworkManagerPracticeTests
//
//  Created by Jackie Lu on 2024/6/27.
//

import XCTest
@testable import NetworkManagerPractice

final class NetworkManagerPracticeTests: XCTestCase {
    let sut = CatAPIManager.stub

    func testGetImage() async throws {
        let images = try await sut.getImages()
        XCTAssertEqual(images.count, 10)
    }
    
    func testAddToFavorite() async throws {
        let id = try await sut.addToFavorite(imageID: "")
        XCTAssertEqual(100038507, id)
    }
    
    func testGetFavorite() async throws {
        do {
            let url = (try await sut.getFavorites()).first!.imageURL
            XCTAssertEqual(url, "https://cdn2.thecatapi.com/images/E8dL1Pqpz.jpg")
        } catch {
            XCTFail("\(error)")
        }
    }
}
