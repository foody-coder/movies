//
//  MovieItem.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/20/22.
//

import Foundation

struct MovieItem: Decodable {
    var backdrop_path: String
    var id: Int
    var original_language: String
    var original_title: String
    var overview: String
    var popularity: Float
    var poster_path: String
    var release_date: String
    var title: String
    var rating: Float
    var isWatched: Bool
}

struct ResultMoviewItem: Decodable, Result {
    var results: [MovieItem]
}

extension MovieItem: Comparable {
    static func < (lhs: MovieItem, rhs: MovieItem) -> Bool {
        lhs.rating == rhs.rating ? lhs.title < rhs.title : lhs.rating < rhs.rating
    }
}
