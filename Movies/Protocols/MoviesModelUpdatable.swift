//
//  MoviesUpdatable.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/30/22.
//

import Foundation

protocol MoviesModelUpdatable {
    func didWatch()
    func update(items: [MovieViewModel]?)
}
