//
//  ContentMovie.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/30/22.
//

import UIKit

protocol ContentMovie {
    var label: UILabel { get }
    var posterImageView: PosterImageView { get }
    var cellStackView: UIStackView { get }
    var contentView: UIView { get }
}
