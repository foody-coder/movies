//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/19/22.
//

import Foundation

final class MoviesViewModel {
    private let listService: FetchService
    private let favoritesService: FetchService
    private let mapperService: MapperService

    init(listService: FetchService, favoritesService: FetchService, mapperService: MapperService) {
        self.listService = listService
        self.favoritesService = favoritesService
        self.mapperService = mapperService
    }
}

extension MoviesViewModel: MoviesViewModellable {
    func update() {
        Task {
            guard let moviesListsData  = try? await listService.execute(),
            let favoritesListData = try? await favoritesService.execute() else { return }

            let moviesLists = try? await mapperService.execute(moviesListsData).sorted(by: <)
            let favoritesLists = try? await mapperService.execute(favoritesListData).sorted(by: <)

        }
    }
}
