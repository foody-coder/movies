//
//  MapperService.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/20/22.
//

import Foundation

struct MapperService: InputService {
    typealias Model = [MovieItem]
    typealias InputType = Data

    func execute(_ input: Data) async throws -> [MovieItem] {
        do {
            let resultItem: ResultItem = try JSONDecoder().decode(ResultItem.self, from: input)
            return resultItem.results
        } catch {
            print(error)
        }
        return []
    }
}
