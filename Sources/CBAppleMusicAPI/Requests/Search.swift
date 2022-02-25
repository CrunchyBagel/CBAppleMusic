//
//  Search.swift
//  
//
//  Created by Quentin Zervaas on 25/2/2022.
//

import Foundation

extension AppleMusicAPI {
    public func searchEditorialPlaylists(term: String, completion: @escaping (Result<[AppleMusicAPI.Playlist], Swift.Error>) -> Void) {

        self.searchPlaylists(term: term) { result in

            switch result {
            case .success(let playlists):
                let editorial = playlists.filter { $0.attributes.playlistType == .editorial }
                completion(.success(editorial))

            case .failure:
                completion(result)
            }
        }
    }

    public func searchPlaylists(term: String, completion: @escaping (Result<[AppleMusicAPI.Playlist], Swift.Error>) -> Void) {
        var components = self.baseComponents(apiCall: .search)

        components.queryItems = [
            URLQueryItem(name: "term", value: term),
            URLQueryItem(name: "limit", value: "25"),
            URLQueryItem(name: "types", value: "playlists"),
        ]

        self.performRequest(type: AppleMusicAPI.SearchResponse.self, urlComponents: components, userToken: nil) { result in

            switch result {
            case .success(let response):
                let playlists = response.results.playlists.data

                completion(.success(playlists))

            case .failure(let error):
                completion(.failure(error))
            }
        }

    }
}
