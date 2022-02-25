//
//  LibraryAlbum.swift
//  
//
//  Created by Quentin Zervaas on 24/2/2022.
//

import Foundation

extension AppleMusicAPI {
    public struct LibraryAlbum: AppleMusicAPIResource {
        static public let type: ResourceType = .libraryAlbums

        public let attributes: LibraryAlbum.Attributes
    }

}

extension AppleMusicAPI.LibraryAlbum {
    public struct Attributes: Codable {
        public let artistName: String
        public let artwork: AppleMusicAPI.Artwork?
        public let contentRating: AppleMusicAPI.ContentRating?
        public let name: String
    }
}



