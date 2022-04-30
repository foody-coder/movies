//
//  Result.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/21/22.
//

import Foundation

protocol Result: Decodable {
    associatedtype Item: Decodable
    var results: [Item] { get }
}
