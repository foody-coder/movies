//
//  DetailControllerBuilder.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/25/22.
//

import UIKit

struct DetailsControllerBuilder: Building {
    var selected: MovieViewModel?

    func build() -> UIViewController? {
        guard let viewModel = self.selected else { return nil }
        let detailViewController = MovieDetailViewContoller(viewModel: viewModel)
        return detailViewController
    }
}
