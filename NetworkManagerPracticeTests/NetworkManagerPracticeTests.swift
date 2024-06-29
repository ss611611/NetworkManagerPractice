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
    func testFavoritePaginatingAllPage() async {
            let testFirstRequest = await sut.getFavorites(page: 0, limit: 5)
            XCTAssertEqual(testFirstRequest, .success(nextPage: 1))
            XCTAssertEqual(5, sut.favorites.count)

            let testSecondRequest = await sut.getFavorites(page: 1, limit: 5)
            XCTAssertEqual(testSecondRequest, .success(nextPage: 2))
            XCTAssertEqual(10, sut.favorites.count)

            let testThirdRequest = await sut.getFavorites(page: 2, limit: 5)
            XCTAssertEqual(testThirdRequest, .success(nextPage: nil))
            XCTAssertEqual(13, sut.favorites.count)
        }
    
    @MainActor
    func testFavoritePagination() async {
            await runFavoriteFetchTestHelper(page: 1, limit: 5, expectedState: .success(nextPage: 2), expectedResultCount: 5)
            await runFavoriteFetchTestHelper(page: 2, limit: 5, expectedState: .success(nextPage: nil), expectedResultCount: 3)
            await runFavoriteFetchTestHelper(page: 5, limit: 5, expectedState: .success(nextPage: nil), expectedResultCount: 0)
        }
}


extension CatAPIManager {
    static var stub: CatAPIManager { .init(getData: \.stub) }
}

// MARK: helper
extension NetworkManagerPracticeTests {
    func runFavoriteFetchTestHelper(page: Int, limit: Int, expectedState: FavoriteLoadingState, expectedResultCount: Int) async {
        sut = await .stub
        let result = await sut.getFavorites(page: page, limit: limit)
        XCTAssertEqual(result, expectedState)
        
        let favoriteCount = await MainActor.run { sut.favorites.count }
        XCTAssertEqual(favoriteCount, expectedResultCount)
    }
}

