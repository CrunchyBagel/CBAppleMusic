//
//  LibrarySong.swift
//  
//
//  Created by Quentin Zervaas on 24/2/2022.
//

import Foundation

extension AppleMusicAPI {
    public struct LibrarySong: AppleMusicAPIResource {
        static public let type: ResourceType = .librarySongs

        public let id: String
        public let href: String
        public let attributes: LibrarySong.Attributes
        public let relationships: [LibrarySong.Relationships]?
    }
}

extension AppleMusicAPI.LibrarySong: Identifiable { }

extension AppleMusicAPI.LibrarySong {
    public struct Attributes: Codable, Hashable {
        public let albumName: String?
        public let artistName: String?
        public let artwork: AppleMusicAPI.Artwork?
        public let contentRating: AppleMusicAPI.ContentRating?
        public let durationInMillis: Int
        public let name: String
        public let playParams: PlayParams?
    }

    public struct Relationships: Codable {
        //        public let albums
        //        public let artists
        public let catalog: CatalogRelationship?
    }

    public struct CatalogRelationship: Codable {
        public let href: String?
        public let next: String?
        public let data: [AppleMusicAPI.Song]
    }

    public struct PlayParams: Codable, Hashable {
        public let id: String
        public let kind: String
        public let isLibrary: Bool
        public let isReporting: Bool
        public let catalogId: String?
        public let reportingId: String?
    }
}
