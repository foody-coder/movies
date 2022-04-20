//
//  FetchService.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/19/22.
//

import Foundation

struct FetchService {
    typealias Model = Data

    var networkSession: NetworkSession
    var url: URL
}

extension FetchService: Service {
    func execute() async throws -> Data {
        let data = try await networkSession.fetch(from: url)
        return data
    }
}
