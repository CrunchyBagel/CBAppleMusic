//
//  ResponseTypes.swift
//  
//
//  Created by Quentin Zervaas on 24/2/2022.
//

import Foundation


extension AppleMusicAPI {
    /// https://developer.apple.com/documentation/applemusicapi/searchresponse
    struct SearchResponse: Codable {
        let results: SearchResults
    }

    /// https://developer.apple.com/documentation/applemusicapi/searchresults
    struct SearchResults: Codable {
        let playlists: PlaylistResponse
    }

    /// https://developer.apple.com/documentation/applemusicapi/playlistresponse
    struct PlaylistResponse: Codable, Sendable {
        let data: [Playlist]
    }

    /// https://developer.apple.com/documentation/applemusicapi/recommendationresponse
    struct RecommendationResponse: Codable {
        let data: [Recommendation]
    }

    //// https://developer.apple.com/documentation/applemusicapi/libraryplaylistsresponse
    struct LibraryPlaylistResponse: Codable {
        let next: String?
        let data: [LibraryPlaylist]
        let meta: Meta?
    }
}

extension AppleMusicAPI.LibraryPlaylistResponse {
    struct Meta: Codable, Sendable {
        let total: Int
    }
}
