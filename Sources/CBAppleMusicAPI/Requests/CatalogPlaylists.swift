//
//  CatalogPlaylists.swift
//  
//
//  Created by Quentin Zervaas on 25/2/2022.
//

import Foundation

extension AppleMusicAPI {
    @available(*, renamed: "requestPlaylistInfo(playlists:)")
    public func requestPlaylistInfo(playlists: [AppleMusicAPI.Playlist], completion: @escaping (Result<[AppleMusicAPI.Playlist], Swift.Error>) -> Void) {

        guard playlists.count > 0 else {
            completion(.failure(Error.invalidRequestData))
            return
        }

        let idParams: [URLQueryItem] = playlists.map { URLQueryItem(name: "ids", value: $0.id) }

        var components = self.baseComponents(apiCall: .playlists)
        components.queryItems = idParams

        self.performRequest(type: PlaylistResponse.self, urlComponents: components, userToken: nil) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    @available(iOS 13, watchOS 6, tvOS 13, *)
    public func requestPlaylistInfo(playlists: [AppleMusicAPI.Playlist]) async throws -> [AppleMusicAPI.Playlist] {
        try await withCheckedThrowingContinuation { continuation in
            requestPlaylistInfo(playlists: playlists) { result in
                continuation.resume(with: result)
            }
        }
    }
    
}
