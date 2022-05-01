//
//  MoviesViewModelTests.swift
//  MoviesTests
//
//  Created by Oleksandr Buhara on 5/1/22.
//

import XCTest
@testable import Movies

class MoviesViewModelTests: XCTestCase {

    func testExample() async throws {
        let mockURLSession = MockURLSession(api: .list, index: 5)
        let networkManager = NetworkSession(mockURLSession)
        let fetchService = FetchService(networkSession: networkManager)
        let mapperService = MapperService()

        let moviesModel = MoviesViewModel(fetchService: fetchService,
                                          mapperService: mapperService)

        guard let movies = try? await moviesModel.movies() else {
            XCTFail("fetch service returned nil data")
            return
        }

        let titles = movies.map { $0.title }
        let favoritesIds = movies.filter { $0.isFavorite == true }.map { $0.id }
        let watchedIds = movies.filter { $0.isWatched == true }.map { $0.id }

        XCTAssertEqual(favoritesIds, [20, 4, 3, 2, 1], "favorites ids mismatched with expected")
        XCTAssertEqual(watchedIds, [3, 1], "watched ids mismatched with expected")

        XCTAssertEqual(favoritesIds.count, 5, "favorites movies mismatched with expected")
        XCTAssertEqual(watchedIds.count, 2, "favorites movies mismatched with expected")

        XCTAssertEqual(movies.count, 5, "expected movies list count mismatch")
        XCTAssertEqual(titles, ["A", "B", "D", "E", "F"], "expacted titles mismatch faild sort")
    }

}
