//
//  PosterInageView.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/24/22.
//

import UIKit

final class PosterImageView: UIImageView {

    func configure() {
        self.layer.cornerRadius = intrinsicContentSize.width/2
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.gray.cgColor
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: 40, height: 40)
    }
}
