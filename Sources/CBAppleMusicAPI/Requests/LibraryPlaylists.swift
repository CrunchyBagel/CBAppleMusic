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
    public func myPlaylists(
        userToken: String,
        completion: @escaping @Sendable (Result<[AppleMusicAPI.LibraryPlaylist], Swift.Error>) -> Void
    ) {

        let components = self.baseComponents(apiCall: .libraryPlaylists)
        
        myPlaylists(
            userToken: userToken,
            components: components,
            completion: completion
        )
    }

    private func myPlaylists(
        userToken: String,
        components: URLComponents,
        completion: @escaping @Sendable (Result<[AppleMusicAPI.LibraryPlaylist], Swift.Error>) -> Void
    ) {
        self.performRequest(
            type: LibraryPlaylistResponse.self,
            urlComponents: components,
            userToken: userToken
        ) { result in

            switch result {
            case .failure(let error):
                completion(.failure(error))

            case .success(let response):
                let playlists = response.data

                if let next = response.next {
                    let nextComponents = self.components(nextURL: next)

                    self.myPlaylists(
                        userToken: userToken,
                        components: nextComponents
                    ) { result in
                            switch result {
                            case .failure:
                                completion(.success(playlists))
                            case .success(let nextPlaylists):
                                completion(.success(playlists + nextPlaylists))
                            }
                        }
                }
                else {
                    completion(.success(playlists))
                }
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
    public func libraryPlaylistInfo(
        userToken: String,
        playlist: AppleMusicAPI.LibraryPlaylist,
        include: Set<IncludeRelationships>,
        completion: @escaping @Sendable (Result<AppleMusicAPI.LibraryPlaylist, Swift.Error>) -> Void
    ) {

        var components = self.baseComponents(apiCall: .libraryPlaylists, pathComponents: [playlist.id])
        components.queryItems = include.map { URLQueryItem(name: "include", value: $0.rawValue) }

        self.performRequest(
            type: LibraryPlaylistResponse.self,
            urlComponents: components,
            userToken: userToken
        ) { result in

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
