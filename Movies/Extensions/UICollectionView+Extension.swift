//
//  UICollectionView+Extension.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/24/22.
//

import UIKit

extension UICollectionView {
    func registerCell<Cell: UICollectionViewCell>(_ type: Cell.Type) {
        register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
    }

    func dequeue<Cell>(for indexPath: IndexPath) -> Cell where Cell: UICollectionViewCell {
        dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
    }
}
