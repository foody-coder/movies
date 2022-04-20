//
//  URLSessionProtocol.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/20/22.
//

import Foundation

protocol URLSessionProtocol {
    func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}
