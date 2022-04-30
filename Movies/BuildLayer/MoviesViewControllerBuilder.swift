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
        let networkSession = NetworkSession()
        let fetchService = FetchService(networkSession: networkSession)
        let mapperService = MapperService()
        let viewModel = MoviesViewModel(fetchService: fetchService, mapperService: mapperService)
        let router = MoviesCollectionRouter(builder: DetailsControllerBuilder())


        let moviesCollectionViewModel = MoviesCollectionViewModel()
        let collectionViewController = MoviesCollectionViewController(moviesCollectionViewModel, collectionViewLayout: MoviesCollectionViewController.createLayout())
        viewModel.collectionViewModel = moviesCollectionViewModel

        let moviesViewController = MoviesViewController(collectionViewController: collectionViewController,
                                                        viewModel: viewModel,
                                                        router: router)

        let navigationController = UINavigationController(rootViewController: moviesViewController)
        router.navigationViewController = navigationController
        return navigationController
    }
}
