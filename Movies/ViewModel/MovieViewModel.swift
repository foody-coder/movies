//
//  MovieViewModel.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/21/22.
//

import Foundation

final class MovieViewModel {
    let id: Int
    let imageData: Data?
    let title: String
    let description: String
    let rating: String
    let date: String
    let originalLanguage: String
    var isWatched: Bool
    var isFavorite: Bool

    init(id: Int,
         imageData: Data?,
         title: String,
         description: String,
         rating: String,
         date: String,
         originalLanguage: String,
         isWatched: Bool = false,
         isFavorite: Bool = false) {
        self.id = id
        self.imageData = imageData
        self.title = title
        self.description = description
        self.rating = rating
        self.date = date
        self.originalLanguage = originalLanguage
        self.isWatched = isWatched
        self.isFavorite = isFavorite
    }

    convenience init(item: MovieItem, imageData: Data?, isFavorite: Bool) {
        self.init(id: item.id,
                  imageData: imageData,
                  title: item.title,
                  description: item.overview,
                  rating: "\(item.rating)",
                  date: item.release_date,
                  originalLanguage: item.original_language,
                  isFavorite: isFavorite)
    }
}
