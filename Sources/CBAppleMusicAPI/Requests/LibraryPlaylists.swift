//
//  LibraryPlaylists.swift
//  
//
//  Created by Quentin Zervaas on 25/2/2022.
//

import Foundation

extension AppleMusicAPI {
    public enum IncludeRelationships: String {
        case catalog = "catalog"
        case tracks = "tracks"
    }

    @available(*, renamed: "myPlaylists(userToken:)")
    public func myPlaylists(userToken: String, completion: @escaping (Result<[AppleMusicAPI.LibraryPlaylist], Swift.Error>) -> Void) {

        let components = self.baseComponents(apiCall: .libraryPlaylists)

        self.performRequest(type: LibraryPlaylistResponse.self, urlComponents: components, userToken: userToken) { result in

            switch result {
            case .failure(let error):
                completion(.failure(error))

            case .success(let response):
                completion(.success(response.data))
            }
        }
    }
    
    @available(iOS 13, watchOS 6, tvOS 13, *)
    public func myPlaylists(userToken: String) async throws -> [AppleMusicAPI.LibraryPlaylist] {
        try await withCheckedThrowingContinuation { continuation in
            myPlaylists(userToken: userToken) { result in
                continuation.resume(with: result)
            }
        }
    }
    

    @available(*, renamed: "libraryPlaylistInfo(userToken:playlist:include:)")
    public func libraryPlaylistInfo(userToken: String, playlist: AppleMusicAPI.LibraryPlaylist, include: Set<IncludeRelationships>, completion: @escaping (Result<AppleMusicAPI.LibraryPlaylist, Swift.Error>) -> Void) {

        var components = self.baseComponents(apiCall: .libraryPlaylists, pathComponents: [playlist.id])
        components.queryItems = include.map { URLQueryItem(name: "include", value: $0.rawValue) }

        self.performRequest(type: LibraryPlaylistResponse.self, urlComponents: components, userToken: userToken) { result in

            switch result {
            case .failure(let error):
                completion(.failure(error))

            case .success(let response):
                completion(.success(response.data.first ?? playlist))
            }
        }
    }
    
    @available(iOS 13, watchOS 6, tvOS 13, *)
    public func libraryPlaylistInfo(userToken: String, playlist: AppleMusicAPI.LibraryPlaylist, include: Set<IncludeRelationships>) async throws -> AppleMusicAPI.LibraryPlaylist {
        try await withCheckedThrowingContinuation { continuation in
            libraryPlaylistInfo(userToken: userToken, playlist: playlist, include: include) { result in
                continuation.resume(with: result)
            }
        }
    }
    
}
