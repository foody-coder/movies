//
//  MovieDetailViewContoller.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/19/22.
//

import UIKit

final class MovieDetailViewContoller: UIViewController, ContentMovie {
    private let viewModel: MovieViewModel
    private (set)var label = UILabel()
    var posterImageView = PosterImageView()
    var cellStackView = UIStackView()
    var contentView = UIView()
    var stackView = UIStackView()

    init(viewModel: MovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center

        view.addSubview(stackView)
        let inset = CGFloat(10)
        let margins = view.layoutMarginsGuide

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: inset),
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -inset),
            stackView.topAnchor.constraint(equalTo: margins.topAnchor, constant: inset),
            stackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -inset)
        ])


        //let stackView = UIStackView(arrangedSubviews: [contentView])
        stackView.addArrangedSubview(contentView)
        setupContent(sectionType: .favorites)
        stackView.alignment = .center

        if let imageData = viewModel.imageData {
            posterImageView.image = UIImage(data: imageData)
            posterImageView.configure()
        }
        label.text = viewModel.title

        let descriptionStack = UIStackView()
        descriptionStack.translatesAutoresizingMaskIntoConstraints = false
        descriptionStack.axis = .vertical
        descriptionStack.alignment = .leading
        stackView.addArrangedSubview(descriptionStack)


        let descriptionLabel = UILabel()
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        let ratingLabel = UILabel()
        let dateLabel = UILabel()
        let originalLanguageLabel = UILabel()

        descriptionLabel.text = viewModel.description
        ratingLabel.text = viewModel.rating
        dateLabel.text = viewModel.date
        originalLanguageLabel.text = viewModel.originalLanguage

        descriptionStack.addArrangedSubview(titleStack(forLabel: descriptionLabel, title: "Description:", isHorisontal: false))
        descriptionStack.addArrangedSubview(titleStack(forLabel: ratingLabel, title: "Rating:"))
        descriptionStack.addArrangedSubview(titleStack(forLabel: dateLabel, title: "Date:"))
        descriptionStack.addArrangedSubview(titleStack(forLabel: originalLanguageLabel, title: "Language:"))

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(view)

        contentView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        descriptionLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        ratingLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        dateLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        originalLanguageLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
    }

    private func titleStack(forLabel: UILabel, title: String, isHorisontal: Bool = true) -> UIStackView {

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)

        let stackView = UIStackView(arrangedSubviews: [titleLabel, forLabel])
        stackView.spacing = 5
        stackView.axis = isHorisontal == true ? .horizontal : .vertical

        return stackView
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
