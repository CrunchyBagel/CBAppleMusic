//
//  CatalogPlaylists.swift
//  
//
//  Created by Quentin Zervaas on 25/2/2022.
//

import Foundation

extension AppleMusicAPI {
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
}
