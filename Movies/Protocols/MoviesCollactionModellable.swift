//
//  MoviesCollactionModellable.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/24/22.
//

import Foundation

enum SectionType: Int, CaseIterable {
    case favorites
    case watched
    case toWatch

    var title: String {
        switch self {
        case .favorites: return "Favorites"
        case .watched: return "Watched"
        case .toWatch: return "To watch"
        }
    }
}

protocol SectionProtocol {
    associatedtype Item
    var title: String { get }
    var items: [Item] { get }
    var type: SectionType { get }
    subscript(index: Int) -> Item? { get }
}

protocol MoviesCollactionModellable {
    var selectedViewModel: MovieViewModel? { get }
    associatedtype Section: SectionProtocol
    subscript(index: Int) -> Section? { get }
}
