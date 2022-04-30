//
//  MoviesCollectionViewModel.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/24/22.
//

import Foundation

struct MoviesSection: SectionProtocol {
    var items: [MovieViewModel]
    var type: SectionType
    var title: String { type.title }

    subscript(index: Int) -> MovieViewModel? {
        get {
            guard index < items.count else { return nil }
            return items[index]
        }
    }
}

final class MoviesCollectionViewModel: MoviesCollactionModellable {
    struct IndexPath {
        var section: Int
        var index: Int
    }
    typealias ViewModelIdentifier = Int

    var isSelectedMovie: Bool { self.selectedViewModel != nil }
    var sectionsCount: Int { sections.count }

    private var sections = [MoviesSection]()
    private(set) var selectedViewModel: MovieViewModel?
    private(set) var viewModels: [MovieViewModel] = []
    private var viewModelsIndexesDictionary = [ViewModelIdentifier: [IndexPath]]()

    func select(sectionIndex: Int, index: Int) {
        let section = self[sectionIndex]
        let item = section?[index]

        if selectedViewModel === item {
            self.selectedViewModel = nil
        } else {
            self.selectedViewModel = section?[index]
        }
    }

    var selectedIndexPaths: [IndexPath]? {
        guard let id = self.selectedViewModel?.id else { return nil }
        return viewModelsIndexesDictionary[id]
    }

    subscript(index: Int) -> MoviesSection? {
        get {
            guard index < sections.count else { return nil }
            return sections[index]
        }
    }

    func isSelected(viewModel: MovieViewModel) -> Bool {
        guard let selectedViewModel = selectedViewModel else {
             return false
        }
        return selectedViewModel.id == viewModel.id
    }
}

extension MoviesCollectionViewModel: MoviesModelUpdatable {
    func didWatch() {
        selectedViewModel?.isWatched = true
        clean()
        update(items: self.viewModels)
    }

    func clean() {
        self.sections.removeAll()
        self.viewModelsIndexesDictionary.removeAll()
    }

    func update(items: [MovieViewModel]?) {
        guard let items = items, !items.isEmpty else { return }
        self.viewModels = items

        let favorites = items.filter { $0.isFavorite }
        let watched = items.filter { $0.isWatched }
        let toWatch = items.filter { !$0.isWatched }

        let sections: [SectionType: [MovieViewModel]] = [
            .favorites: favorites,
            .watched: watched,
            .toWatch: toWatch
        ]

        var index: Int = 0
        for enumerated in SectionType.allCases {
            guard let items = sections[enumerated], !items.isEmpty else { continue }
            let section = MoviesSection(items: items, type: enumerated)
            self.sections.append(section)
            updateIndexPaths(viewModels: items, sectionIndex: index)
            index += 1
        }
    }

    private func updateIndexPaths(viewModels: [MovieViewModel], sectionIndex: Int) {
        viewModels.enumerated().forEach {
            if let indexPaths = viewModelsIndexesDictionary[$0.element.id] {
                var newIndexPaths = indexPaths
                newIndexPaths.append(IndexPath(section: sectionIndex, index: $0.offset))
                viewModelsIndexesDictionary[$0.element.id] = newIndexPaths
            } else {
                let indexPath = IndexPath(section: sectionIndex, index: $0.offset)
                viewModelsIndexesDictionary[$0.element.id] = [indexPath]
            }
        }
    }
}
