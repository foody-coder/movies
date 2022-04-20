//
//  Service.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/20/22.
//

import Foundation

protocol InputService {
    associatedtype Model
    associatedtype InputType
    func execute(_ input: InputType) async throws -> Model
}

protocol Service {
    associatedtype Model
    func execute() async throws -> Model
}
