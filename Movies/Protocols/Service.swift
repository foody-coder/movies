//
//  Service.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/20/22.
//

import Foundation

protocol InputService {
    func execute<ResultItem>(_ input: Data, mapType: ResultItem.Type) async throws -> [ResultItem.Item] where ResultItem: Result
}

protocol Service {
    associatedtype Model
    func execute(api: MoviesAPI) async throws -> Model
}
