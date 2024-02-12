//
//  Station.swift
//  
//
//  Created by Quentin Zervaas on 24/2/2022.
//

import Foundation

extension AppleMusicAPI {
    public struct Station: AppleMusicAPIResource {
        static public let type: ResourceType = .stations

        public let attributes: Station.Attributes
    }
}

extension AppleMusicAPI.Station {
    public struct Attributes: Codable, Sendable {
        public let name: String
        public let artwork: AppleMusicAPI.Artwork?
        public let url: URL?
    }
}



