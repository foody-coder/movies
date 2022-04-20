//
//  MovieViewModel.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/21/22.
//

import UIKit

final class MovieViewModel {
    let image: UIImage
    let title: String
    var isSelected: Bool

    init(image: UIImage, title: String, isSelected: Bool = false) {
        self.image = image
        self.title = title
        self.isSelected = isSelected
    }
}
