//
//  MockURLSession.swift
//  MoviesTests
//
//  Created by Oleksandr Buhara on 4/20/22.
//

import Foundation
import Movies

final class MockURLSession {
}

extension MockURLSession: URLSessionProtocol {
    func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
       return (Data(), URLResponse())
    }
}
