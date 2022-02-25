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
    public struct Attributes: Codable {
        public struct Description: Codable {
            let standard: String
        }

        public let artwork: AppleMusicAPI.Artwork?
        public let dateAdded: Date?
        public let description: Description?
        public let hasCatalog: Bool
        public let name: String?
    }

    public struct Relationships: Codable {
        public let catalog: CatalogRelationship?
        public let tracks: TracksRelationship?
    }

    public struct CatalogRelationship: Codable {
        public let href: String?
        public let next: String?
        public let data: [AppleMusicAPI.Playlist]
    }

    public struct TracksRelationship: Codable {
        public let href: String?
        public let next: String?
        public let data: [AppleMusicAPI.AnyResource]
    }
}
