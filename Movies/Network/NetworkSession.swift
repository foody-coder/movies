//
//  NetworkSession.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/19/22.
//

import Foundation

enum NetworkError: Error {
    case invalidServerResponce
}

extension URLSession: URLSessionProtocol {
}

final class NetworkSession {
    private let urlSession: URLSessionProtocol

    init(_ urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }

    func fetch(from: URL) async throws -> Data {
        let (data, response) = try await urlSession.data(from: from, delegate: nil)

        guard let httpResponce = response as? HTTPURLResponse,
                httpResponce.statusCode == 200 else {
            throw NetworkError.invalidServerResponce
        }

        return data
    }
}
