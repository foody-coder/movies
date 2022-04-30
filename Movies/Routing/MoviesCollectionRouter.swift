//
//  MoviesCollectionRouter.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/24/22.
//

import UIKit

final class MoviesCollectionRouter: Routable {
    var builder: DetailsControllerBuilder
    weak var navigationViewController: UINavigationController?

    init(builder: DetailsControllerBuilder) {
        self.builder = builder
    }

    func next(item: MovieViewModel?, title: String?) {
        builder.selected = item
        guard let detailViewController = builder.build() else { return }
        detailViewController.navigationItem.title = title
        navigationViewController?.show(detailViewController, sender: self)
    }
}
