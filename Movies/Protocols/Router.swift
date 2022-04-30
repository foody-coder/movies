//
//  Router.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/24/22.
//

import Foundation

protocol Routable {
    associatedtype Item
    associatedtype Build
    var builder: Build { get }
    func next(item: Item?, title: String?)
}
