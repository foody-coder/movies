//
//  FetchServiceTests.swift
//  MoviesTests
//
//  Created by Oleksandr Buhara on 4/19/22.
//

import XCTest
@testable import Movies

class FetchServiceTests: XCTestCase {

    func testURL() {
        guard let listURL = MoviesAPI.list.url else {
            XCTFail("list url is nil")
            return
        }
        guard let favoritesURL = MoviesAPI.favorites.url else {
            XCTFail("favorites url is nil")
            return
        }

        let mockListURLSession = MockURLSession(api: .list)
        XCTAssertEqual(mockListURLSession.matchInformation.urlPath,
                       listURL.absoluteString,
                       "url value for list is mismatched with expected")

        let mockFavoritesURLSession = MockURLSession(api: .favorites)
        XCTAssertEqual(mockFavoritesURLSession.matchInformation.urlPath,
                       favoritesURL.absoluteString,
                       "url value for favorites is mismatched with expected")

    }

    func testMoviesList() async throws {
        let mockURLSession = MockURLSession(api: .list)
        let networkManager = NetworkSession(mockURLSession)
        let fetchService = FetchService(networkSession: networkManager)
        guard let data = try? await fetchService.execute(api: MoviesAPI.list) else {
            XCTFail("fetch service returned nil data")
            return
        }
        let mapperService = MapperService()
        guard let movies = try? await mapperService.execute(data, mapType: ResultMoviewItem.self) else {
            XCTFail("mapping service returned nil")
            return
        }

        let oneToThree = Array(1...3)
        let added20 = oneToThree + [20]
        let allIds = added20 + Array(4...19)
        let fetchedIds = movies.map { $0.id }

        XCTAssertEqual(fetchedIds.count, 20, "expected movies list count mismatch")
        XCTAssertEqual(allIds, fetchedIds, "array id's mismatched with expected")

    }

    func testMoviesListWithEqualRatings() async throws {
        let mockURLSession = MockURLSession(api: .list, index: 5)
        let networkManager = NetworkSession(mockURLSession)
        let fetchService = FetchService(networkSession: networkManager)
        guard let data = try? await fetchService.execute(api: MoviesAPI.list) else {
            XCTFail("fetch service returned nil data")
            return
        }
        let mapperService = MapperService()
        guard let movies = try? await mapperService.execute(data, mapType: ResultMoviewItem.self).sorted(by: <) else {
            XCTFail("mapping service returned nil")
            return
        }

        let titles = movies.map { $0.title }

        XCTAssertEqual(movies.count, 5, "expected movies list count mismatch")
        XCTAssertEqual(titles, ["A", "B", "D", "E", "F"], "expacted titles mismatch faild sort")
    }

    func testMoviesListWithDifferentRatings() async throws {
        let mockURLSession = MockURLSession(api: .list, index: 6)
        let networkManager = NetworkSession(mockURLSession)
        let fetchService = FetchService(networkSession: networkManager)
        guard let data = try? await fetchService.execute(api: MoviesAPI.list) else {
            XCTFail("fetch service returned nil data")
            return
        }
        let mapperService = MapperService()
        guard let movies = try? await mapperService.execute(data, mapType: ResultMoviewItem.self).sorted(by: <) else {
            XCTFail("mapping service returned nil")
            return
        }

        let titles = movies.map { $0.title }

        XCTAssertEqual(movies.count, 5, "expected movies list count mismatch")
        XCTAssertEqual(titles, ["F", "E", "D", "A", "B"], "expacted titles mismatch faild sort")
    }

    func testFavorites() async throws {
        let mockURLSession = MockURLSession(api: .favorites)
        let networkManager = NetworkSession(mockURLSession)
        let fetchService = FetchService(networkSession: networkManager)
        guard let data = try? await fetchService.execute(api: MoviesAPI.favorites) else {
            XCTFail("fetch service returned nil data")
            return
        }
        let mapperService = MapperService()
        guard let favorites = try? await mapperService.execute(data, mapType: ResultFavoriteItem.self) else {
            XCTFail("mapping service returned nil")
            return
        }

        let ids = favorites.map { $0.id }

        XCTAssertEqual(favorites.count, 6, "expected favoritees count mismatch")
        XCTAssertEqual(ids, [1, 8, 9, 12, 16, 17], "expacted favorites mismatch sort")
    }

}
