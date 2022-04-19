//
//  MoviesViewControllerBuilder.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/19/22.
//

import UIKit

struct MoviesViewControllerBuilder {
    private let viewModel = MoviesViewModel()
}

extension MoviesViewControllerBuilder: Building {
    func build() -> UIViewController {
        let moviesViewController = MoviesViewController()
        return UINavigationController(rootViewController: moviesViewController)
    }
}
