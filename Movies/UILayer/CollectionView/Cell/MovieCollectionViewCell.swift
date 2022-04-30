//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/24/22.
//

import UIKit

extension ContentMovie {
    func setupContent(sectionType: SectionType) {
        cellStackView.translatesAutoresizingMaskIntoConstraints = false

        switch sectionType {
        case .favorites: cellStackView.axis = .vertical
        case .watched, .toWatch: cellStackView.axis = .horizontal
        }

        cellStackView.alignment = .center
        cellStackView.spacing = 5
        cellStackView.distribution = .fill

        contentView.addSubview(cellStackView)
        contentView.isUserInteractionEnabled = true
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 8

        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.highlightedTextColor = .white
        label.tintColor = .white
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.highlightedTextColor = .white

        posterImageView.setContentHuggingPriority(.defaultHigh, for:.horizontal)
        posterImageView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        posterImageView.setContentHuggingPriority(.defaultHigh, for:.vertical)

        label.setContentHuggingPriority(.defaultLow, for:.horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for:.vertical)

        cellStackView.addArrangedSubview(posterImageView)
        cellStackView.addArrangedSubview(label)

        let inset = CGFloat(10)

        NSLayoutConstraint.activate([
            cellStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            cellStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            cellStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            cellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])

    }
}

final class MovieCollectionViewCell: UICollectionViewCell {
    let label = UILabel()
    let posterImageView = PosterImageView()
    let cellStackView = UIStackView()
}

extension MovieCollectionViewCell: ContentMovie {
    func configure(sectionType: SectionType) {

        setupContent(sectionType: sectionType)

        let redView = UIView(frame: bounds)
        redView.layer.cornerRadius = 8
        redView.layer.masksToBounds = true
        redView.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.backgroundView = redView

        let blueView = UIView(frame: bounds)
        blueView.layer.cornerRadius = 8
        blueView.layer.masksToBounds = true
        blueView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.selectedBackgroundView = blueView
    }
}
