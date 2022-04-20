//
//  MoviesViewControllerBuilder.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/19/22.
//

import UIKit

struct MoviesViewControllerBuilder {
}

extension MoviesViewControllerBuilder: Building {
    func build() -> UIViewController? {
        guard let url = URL(string: "https://61efc467732d93001778e5ac.mockapi.io/movies/list") else { return nil }
        let networkSession = NetworkSession()
        let listFetchService = FetchService(networkSession: networkSession, url: url)
        let favoritesService = FetchService(networkSession: networkSession, url: url)
        let mapperService = MapperService()
        let viewModel = MoviesViewModel(listService: listFetchService, favoritesService: favoritesService, mapperService: mapperService)
        let moviesViewController = MoviesViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: moviesViewController)
    }
}
