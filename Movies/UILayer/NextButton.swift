//
//  NextButton.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/24/22.
//

import UIKit

final class NextButton: UIButton {

    override public var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .blue : .systemBlue
        }
    }

    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? .systemBlue : .lightGray
        }
    }
}
