//
//  MapperService.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/20/22.
//

import Foundation

struct MapperService: InputService {
    func execute<ResultItem>(_ input: Data, mapType: ResultItem.Type) async throws -> [ResultItem.Item] where ResultItem: Result {
        do {
            let resultItem: ResultItem = try JSONDecoder().decode(ResultItem.self, from: input)
            return resultItem.results
        } catch {
            print(error)
        }
        return []
    }
}
