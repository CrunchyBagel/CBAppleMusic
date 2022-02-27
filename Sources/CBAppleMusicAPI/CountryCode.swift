//
//  CountryCode.swift
//  
//
//  Created by Quentin Zervaas on 28/2/2022.
//

import Foundation

extension AppleMusicAPI {
    public struct CountryCode {
        public let code: String

        public init(code: String) {
            self.code = code
        }
    }
}

extension AppleMusicAPI.CountryCode: Codable {}

extension AppleMusicAPI.CountryCode: Hashable {}

extension AppleMusicAPI.CountryCode: RawRepresentable {
    public init?(rawValue: String) {
        self.code = rawValue
    }

    public var rawValue: String {
        code
    }
}
