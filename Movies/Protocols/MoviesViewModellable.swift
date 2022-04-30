//
//  MoviesViewModellable.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/19/22.
//

import Foundation

protocol MoviesViewModelable {
    var navigationTitle: String { get }
    var buttonTitle: String { get }
    var collectionViewModel: MoviesCollectionViewModel? { get set }
    var isSelected: Bool { get }
    var selected: MovieViewModel? { get }
    func movies() async throws -> [MovieViewModel]?
}
