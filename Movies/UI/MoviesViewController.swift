//
//  MoviesViewController.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/19/22.
//

import UIKit

final class MoviesViewController: UIViewController {
    private let moviesViewModell: MoviesViewModellable

    init(viewModel: MoviesViewModellable) {
        self.moviesViewModell = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        moviesViewModell.update()
    }

}
