//
//  NetworkManagerPracticeTests.swift
//  NetworkManagerPracticeTests
//
//  Created by Jackie Lu on 2024/6/27.
//

import XCTest
@testable import NetworkManagerPractice

final class NetworkManagerPracticeTests: XCTestCase {
    var sut: CatAPIManager!
    
    @MainActor override func setUp() {
        sut = .stub
    }


    @MainActor
    func testGetImage() async throws {
        let images = try await sut.getImages()
        XCTAssertEqual(images.count, 10)
    }
    
    @MainActor
    func testAddToFavorite() async throws {
        try await sut.addToFavorite(cat: [CatImageViewModel].stub.first!)
        let id = sut.favorites.first!.id
        XCTAssertEqual(100038507, id)
    }
    
    @MainActor
    func testGetFavorite() async throws {
        do {
            try await sut.getFavorites()
            XCTAssertEqual(13, sut.favorites.count)
        } catch {
            XCTFail("❌ Unexpected Error: \(error)")
        }
    }
}


extension CatAPIManager {
    static var stub: CatAPIManager { .init(getData: { $0.stub }) }
}
