//
//  MoviesAPI.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/21/22.
//

import Foundation

enum MoviesAPI {
    case list
    case favorites
    case image(String)

    private func apiComponents(_ baseHost: String, path: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = SettingManager.schema
        components.host   = baseHost
        components.path   = path
        return components
    }

    private func apiURL(_ baseHost: String, path: String?) -> URL? {
        guard let path = path, path.isEmpty == false
            else { return nil }
        return apiComponents(baseHost, path: path).url
    }

    var url: URL? {
        switch self {
        case .list: return apiURL(SettingManager.baseHostMovies, path: SettingManager.moviesListPath)
        case .favorites: return apiURL(SettingManager.baseHostMovies, path: SettingManager.moviesFavoritesPath)
        case .image(let imagePath): return apiURL(SettingManager.baseHostImage, path: SettingManager.imagePath + imagePath)
        }
    }
}
