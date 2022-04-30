//
//  FetchService.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/19/22.
//

import Foundation

struct FetchService {
    var networkSession: NetworkSession
}

enum ServiceError: Error {
    case receivedNilURL
}

extension FetchService: Service {
    func execute(api: MoviesAPI) async throws -> Data {
        guard let url = api.url else { throw ServiceError.receivedNilURL }
        let data = try await networkSession.fetch(from: url)
        return data
    }
}
