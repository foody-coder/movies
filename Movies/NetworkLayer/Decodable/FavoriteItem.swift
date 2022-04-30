//
//  FavoriteItem.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/21/22.
//

import Foundation

struct FavoriteItem: Decodable {
    var id: Int
}

struct ResultFavoriteItem: Decodable, Result {
    var results: [FavoriteItem]
}
