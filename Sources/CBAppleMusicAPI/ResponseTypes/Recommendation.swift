//
//  Recommendation.swift
//  
//
//  Created by Quentin Zervaas on 24/2/2022.
//

import Foundation

extension AppleMusicAPI {
    /// https://developer.apple.com/documentation/applemusicapi/recommendation
    public struct Recommendation: Codable {
        public enum RecommendationType: String, Codable {
            case personalRecommendation = "personal-recommendation"
        }

        public struct Attributes: Codable {
            public struct Title: Codable {
                let stringForDisplay: String
            }

            public let isGroupRecommendation: Bool
            public let nextUpdateDate: Date?
            public let resourceTypes: [String]
            public let title: Title
        }

        public struct Resource: Codable {
//            struct Attributes: Codable {
//
//            }

            public let href: String
            public let id: String
//            let attributes: Attributes
        }

        public struct Relationship: Codable {
            public let href: String
            public let data: [AppleMusicAPI.AnyResource]
        }

        public struct Relationships: Codable {
            public let contents: Relationship
        }

        public let id: String
        public let type: RecommendationType
        public let href: String
        public let attributes: Attributes?
        public let relationships: Relationships?
    }
}

extension AppleMusicAPI.Recommendation: Identifiable { }
