//
//  URLSessionProtocol.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/20/22.
//

import Foundation

public protocol URLSessionProtocol {
    func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}
