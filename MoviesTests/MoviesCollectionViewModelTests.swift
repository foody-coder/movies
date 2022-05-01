//
//  MoviesCollectionViewModelTests.swift
//  MoviesTests
//
//  Created by Oleksandr Buhara on 5/1/22.
//

import XCTest
@testable import Movies

class MoviesCollectionViewModelTests: XCTestCase {

    func testExample() async throws {
        let mockURLSession = MockURLSession(api: .list)
        let networkManager = NetworkSession(mockURLSession)
        let fetchService = FetchService(networkSession: networkManager)
        let mapperService = MapperService()

        let moviesModel = MoviesViewModel(fetchService: fetchService,
                                          mapperService: mapperService)

        guard let movies = try? await moviesModel.movies() else {
            XCTFail("fetch service returned nil data")
            return
        }

        let moviesCollectionViewModel = MoviesCollectionViewModel()
        moviesCollectionViewModel.update(items: movies)

        XCTAssertEqual(moviesCollectionViewModel.sectionsCount, 3, "sections count mismatched with expected")

        moviesCollectionViewModel.select(sectionIndex: 0, index: 0)
        guard let selectedViewModel = moviesCollectionViewModel.selectedViewModel else {
            XCTFail("selection for collection view model after selection returns nil")
            return
        }

        XCTAssertEqual(selectedViewModel.id, 4, "mismatch with expected selected movie view model")

        let expectedSelectedIndexes = [
            MoviesCollectionViewModel.IndexPath(section: 0, index: 0), MoviesCollectionViewModel.IndexPath(section: 2, index: 0)
        ]

        XCTAssertEqual(moviesCollectionViewModel.selectedIndexPaths, expectedSelectedIndexes, "mismatched with expected selected indexPaths")
        XCTAssertTrue(moviesCollectionViewModel.isSelectedMovie)
        moviesCollectionViewModel.select(sectionIndex: 0, index: 0)

        XCTAssertFalse(moviesCollectionViewModel.isSelectedMovie)
        XCTAssertNil(moviesCollectionViewModel.selectedViewModel)
        XCTAssertNil(moviesCollectionViewModel.selectedIndexPaths)

        moviesCollectionViewModel.clean()
        XCTAssertEqual(moviesCollectionViewModel.sectionsCount, 0, "sections count mismatched with expected")
    }
}
