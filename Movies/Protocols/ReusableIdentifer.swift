//
//  ReusableIdentifer.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/24/22.
//

import Foundation

protocol ReusableView: AnyObject {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
