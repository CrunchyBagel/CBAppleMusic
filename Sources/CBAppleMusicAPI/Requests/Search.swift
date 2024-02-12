//
//  Search.swift
//  
//
//  Created by Quentin Zervaas on 25/2/2022.
//

import Foundation

extension AppleMusicAPI {
    @available(*, renamed: "searchEditorialPlaylists(term:)")
    public func searchEditorialPlaylists(
        term: String,
        completion: @escaping @Sendable (Result<[AppleMusicAPI.Playlist], Swift.Error>) -> Void
    ) {

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

    @available(iOS 13, watchOS 6, tvOS 13, *)
    public func searchEditorialPlaylists(term: String) async throws -> [AppleMusicAPI.Playlist] {
        try await withCheckedThrowingContinuation { continuation in
            searchEditorialPlaylists(term: term) { result in
                continuation.resume(with: result)
            }
        }
    }
    

    @available(*, renamed: "searchPlaylists(term:)")
    public func searchPlaylists(
        term: String,
        completion: @escaping @Sendable (Result<[AppleMusicAPI.Playlist], Swift.Error>) -> Void
    ) {
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
    
    @available(iOS 13, watchOS 6, tvOS 13, *)
    public func searchPlaylists(term: String) async throws -> [AppleMusicAPI.Playlist] {
        try await withCheckedThrowingContinuation { continuation in
            searchPlaylists(term: term) { result in
                continuation.resume(with: result)
            }
        }
    }
    
}
