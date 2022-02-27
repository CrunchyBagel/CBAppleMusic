//
//  APIKey.swift
//  
//
//  Created by Quentin Zervaas on 28/2/2022.
//

import Foundation

extension AppleMusicAPI {
    public struct APIKey {
        public let key: String
        public let expiry: Date?

        public init(key: String, expiry: Date?) {
            self.key = key
            self.expiry = expiry
        }
    }
}

extension AppleMusicAPI.APIKey: Codable {}

extension AppleMusicAPI.APIKey: Hashable {}
