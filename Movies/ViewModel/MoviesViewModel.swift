//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/19/22.
//

import Foundation
import UIKit

final class MoviesViewModel {
    private let fetchService: FetchService
    private let mapperService: MapperService
    var collectionViewModel: MoviesCollectionViewModel?
    var navigationTitle = "Movies Application"
    var buttonTitle = "Next"

    init(fetchService: FetchService, mapperService: MapperService) {
        self.fetchService = fetchService
        self.mapperService = mapperService
    }
}

extension MoviesViewModel: MoviesViewModelable {
    var isSelected: Bool {
        collectionViewModel?.isSelectedMovie ?? false
    }
    var selected: MovieViewModel? { collectionViewModel?.selectedViewModel }

    func movies() async throws -> [MovieViewModel]? {

        guard let moviesData  = try? await fetchService.execute(api: .list),
              let favoritesData = try? await fetchService.execute(api: .favorites)
        else { return nil }

        // Getting all favorites ids in Set
        let favoritesIds: Set<Int>? = try? await Set(mapperService.execute(favoritesData, mapType: ResultFavoriteItem.self).map { $0.id })

        // 1. Getting all movies items from server
        // 2. Sorting them by Comparable defined in MovieItem by rating if rating is equal than by title
        // 3. Mapping MobiesItems to MoviewViewModels with checking if It favorit and load image inside asynchronous mapping

        let moviesList = try? await mapperService.execute(moviesData, mapType: ResultMoviewItem.self).sorted(by: <).asyncMap { item -> MovieViewModel in
            let imageData = try? await fetchService.execute(api: .image(item.poster_path))
            return MovieViewModel(item: item, imageData: imageData, isFavorite: favoritesIds?.contains(item.id) ?? false)
        }

        return moviesList
    }
}

extension MoviesViewModel: MoviesModelUpdatable {
    func didWatch() {
        collectionViewModel?.didWatch()
    }

    func update(items: [MovieViewModel]?) {
        collectionViewModel?.update(items: items)
    }
}
