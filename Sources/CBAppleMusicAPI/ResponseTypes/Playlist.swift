//
//  Playlist.swift
//  
//
//  Created by Quentin Zervaas on 9/6/20.
//

import Foundation

extension AppleMusicAPI {
    public struct Playlist: AppleMusicAPIResource, Hashable {
        static public let type: ResourceType = .playlists

        public let id: String
        public let href: String
        public let attributes: Playlist.Attributes
        public let nextUpdateDate: Date?

        public let relationships: Relationships?
    }
}

extension AppleMusicAPI.Playlist {
    public struct Relationships: Codable, Hashable {
        let tracks: AppleMusicAPI.TrackRelationship?
    }

    public struct EditorialNotes: Codable, Hashable {
        let short: String?
        let standard: String?
    }

    public struct PlayParams: Codable, Hashable {
        let id: String
        let kind: String
    }

    public enum PlaylistType: String, Codable, Hashable {
        case userShared = "user-shared"
        case editorial = "editorial"
        case external = "external"
        case personalMix = "personal-mix"
    }

    public struct Attributes: Codable, Hashable {
        public let artwork: AppleMusicAPI.Artwork?
        public let curatorName: String?
        public let description: EditorialNotes?
//        public let lastModifiedDate: String?
        public let name: String
        public let playParams: PlayParams?
        public let playlistType: PlaylistType
        public let url: URL?
    }
}

extension AppleMusicAPI.Playlist {
    public func songs(excludeRating: AppleMusicAPI.ContentRating?) -> [AppleMusicAPI.Song] {

        guard let songs = self.relationships?.tracks?.data else {
            return []
        }

        guard let excludeRating = excludeRating else {
            return songs
        }

        return songs.filter { song -> Bool in
            if let r = song.attributes.contentRating {
                return r != excludeRating
            }
            else {
                return true
            }
        }
    }
}
