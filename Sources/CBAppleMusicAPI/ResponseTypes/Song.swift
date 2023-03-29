//
//  Song.swift
//  
//
//  Created by Quentin Zervaas on 24/2/2022.
//

import Foundation

extension AppleMusicAPI {
    public struct Song: Codable, Hashable {
        public let id: String
        public let href: String
        public let attributes: Attributes
    }
}

extension AppleMusicAPI.Song: Identifiable { }

extension AppleMusicAPI.Song {
    public struct Attributes: Codable, Hashable {
        public let albumName: String
        public let artistName: String
        public let contentRating: AppleMusicAPI.ContentRating?
        public let artwork: AppleMusicAPI.Artwork?
        public let durationInMillis: Int
        public let name: String
    }
}
