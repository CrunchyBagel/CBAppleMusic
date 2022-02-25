//
//  File.swift
//  
//
//  Created by Quentin Zervaas on 24/2/2022.
//

import Foundation

extension AppleMusicAPI {
    public struct Album: AppleMusicAPIResource {
        static public let type: ResourceType = .albums

        public let id: String
        public let href: String
        public let attributes: Album.Attributes
    }
}

extension AppleMusicAPI.Album {
    public struct Attributes: Codable {
        public let artistName: String
        public let name: String
        public let artwork: AppleMusicAPI.Artwork?
        public let contentRating: AppleMusicAPI.ContentRating?
        public let url: URL?
        public let releaseDate: String // YYYY-MM-DD
    }
}
