//
//  MoviesViewController.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/19/22.
//

import UIKit

final class MoviesViewController: UIViewController {
    private weak var nextButton: UIButton?
    private var viewModel: MoviesViewModelable & MoviesModelUpdatable
    private var router: MoviesCollectionRouter
    private let moviesCollectionViewController: MoviesCollectionViewController

    init(collectionViewController: MoviesCollectionViewController,
         viewModel: MoviesViewModelable & MoviesModelUpdatable,
         router: MoviesCollectionRouter) {
        self.moviesCollectionViewController = collectionViewController
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = viewModel.navigationTitle
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        moviesCollectionViewController.delegate = self
        addChild(moviesCollectionViewController)
        moviesCollectionViewController.view.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(moviesCollectionViewController.view)
        moviesCollectionViewController.didMove(toParent: self)

        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(container)

        let nextButton = NextButton(type: .custom)
        nextButton.layer.cornerRadius = 8
        nextButton.layer.masksToBounds = true
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle(viewModel.buttonTitle, for: .normal)
        container.addSubview(nextButton)
        nextButton.backgroundColor = .systemBlue
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.isEnabled = false

        nextButton.addTarget(self, action: #selector(MoviesViewController.next(_:)), for: .touchUpInside)
        self.nextButton = nextButton

        NSLayoutConstraint.activate([
            nextButton.heightAnchor.constraint(equalToConstant: 44),
            nextButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            nextButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            nextButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 4),
            nextButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
        ])

        Task { [unowned self] in
            let movies = try? await viewModel.movies()
            viewModel.update(items: movies)
            moviesCollectionViewController.update()
        }
    }

    @objc
    func next(_ sender: AnyObject) {
        router.next(item: viewModel.selected, title: "Movie Details")
        viewModel.didWatch()
        moviesCollectionViewController.update()
    }
}

extension MoviesViewController: MoviesCollectionDelegate {
    func update() {
        nextButton?.isEnabled = self.viewModel.isSelected
    }
}
