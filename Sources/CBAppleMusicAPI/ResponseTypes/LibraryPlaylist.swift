//
//  LibraryPlaylist.swift
//  
//
//  Created by Quentin Zervaas on 24/2/2022.
//

import Foundation

extension AppleMusicAPI {
    public struct LibraryPlaylist: AppleMusicAPIResource {
        static public let type: ResourceType = .libraryPlaylists

        public let id: String
        public let href: String
        public let attributes: LibraryPlaylist.Attributes
        public let relationships: LibraryPlaylist.Relationships?
    }
}

extension AppleMusicAPI.LibraryPlaylist: Identifiable { }

extension AppleMusicAPI.LibraryPlaylist {
    public struct Attributes: Codable, Sendable {
        public struct Description: Codable, Sendable {
            let standard: String
        }

        public let artwork: AppleMusicAPI.Artwork?
        public let dateAdded: Date?
        public let description: Description?
        public let hasCatalog: Bool
        public let name: String?
    }

    public struct Relationships: Codable, Sendable {
        public let catalog: CatalogRelationship?
        public let tracks: TracksRelationship?
    }

    public struct CatalogRelationship: Codable, Sendable {
        public let href: String?
        public let next: String?
        public let data: [AppleMusicAPI.Playlist]
    }

    public struct TracksRelationship: Codable, Sendable {
        public let href: String?
        public let next: String?
        public let data: [AppleMusicAPI.AnyResource]
    }
}

extension AppleMusicAPI.LibraryPlaylist {
    public func songs(excludeRating: AppleMusicAPI.ContentRating?) -> [AppleMusicAPI.LibrarySong] {

        guard let data = self.relationships?.tracks?.data else {
            return []
        }

        let songs = data.compactMap { $0.data as? AppleMusicAPI.LibrarySong }

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
