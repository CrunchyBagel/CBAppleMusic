//
//  AppleMusicAPIResource.swift
//  
//
//  Created by Quentin Zervaas on 24/2/2022.
//

import Foundation

public protocol AppleMusicAPIResource: Codable, Sendable {
    static var type: AppleMusicAPI.ResourceType { get }
}

/// From https://stackoverflow.com/a/44473156
extension AppleMusicAPI {
    public struct AnyResource: Codable, Sendable {
        public let data: AppleMusicAPIResource

        init(_ base: AppleMusicAPIResource) {
            self.data = base
        }

        private enum CodingKeys : CodingKey {
            case type, data
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            let type = try container.decode(ResourceType.self, forKey: .type)
            self.data = try type.metatype.init(from: decoder)
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            try container.encode(type(of: data).type, forKey: .type)
            try data.encode(to: encoder)
        }
    }
}

extension AppleMusicAPI {
    public enum ResourceType: String, Codable {
        case albums
        case playlists
        case libraryAlbums
        case stations
        case libraryPlaylists = "library-playlists"
        case libraryMusicVideos = "library-music-videos"
        case librarySongs = "library-songs"

        var metatype: AppleMusicAPIResource.Type {
            switch self {
            case .playlists:
                return AppleMusicAPI.Playlist.self
            case .albums:
                return AppleMusicAPI.Album.self
            case .libraryAlbums:
                return AppleMusicAPI.LibraryAlbum.self
            case .stations:
                return AppleMusicAPI.Station.self
            case .libraryPlaylists:
                return AppleMusicAPI.LibraryPlaylist.self
            case .libraryMusicVideos:
                return AppleMusicAPI.LibraryMusicVideo.self
            case .librarySongs:
                return AppleMusicAPI.LibrarySong.self
            }
        }
    }
}
