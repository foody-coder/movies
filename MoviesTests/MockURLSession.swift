//
//  MockURLSession.swift
//  MoviesTests
//
//  Created by Oleksandr Buhara on 4/20/22.
//

import Foundation
@testable import Movies

protocol MatchInformation: AnyObject {
    var fileName: String { get }
    var data: Data? { get }
    var urlPath: String { get }
}

extension MatchInformation {
    var data: Data? {
        guard let path = Bundle(for: Self.self).path(forResource: fileName, ofType: "txt") else {
            return nil
        }
        return try? Data(contentsOf: URL(fileURLWithPath: path))
    }
}

final class MoviesList: MatchInformation {
    var index: Int
    var fileName: String {
        "movies.list" + "\(index)"
    }
    var urlPath = "https://61efc467732d93001778e5ac.mockapi.io/movies/list"

    init(index: Int) {
        self.index = index
    }
}

final class Favorites: MatchInformation {
    var fileName = "favorites"
    var urlPath = "https://61efc467732d93001778e5ac.mockapi.io/movies/favorites"
}

final class ImageInfo: MatchInformation {
    var fileName = ""
    var urlPath = "https://developers.themoviedb.org/3/getting-started/images"
}

final class MockURLSession {
    let api: MoviesAPI
    let matchInformation: MatchInformation

    init(api: MoviesAPI, index: Int = 1) {
        self.api = api
        switch api {
        case .list: self.matchInformation = MoviesList(index: index)
        case .favorites: self.matchInformation = Favorites()
        case .image(_): self.matchInformation = ImageInfo()
        }
    }
}

extension MockURLSession: URLSessionProtocol {

    func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        guard let data = matchInformation.data,
              let response = HTTPURLResponse(url: url,
                                             statusCode: 200,
                                             httpVersion: nil,
                                             headerFields: nil) else {
                  return (Data(), HTTPURLResponse())
              }
        return (data, response)
    }
}
