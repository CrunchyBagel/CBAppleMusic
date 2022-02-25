//
//  TrackRelationship.swift
//  
//
//  Created by Quentin Zervaas on 24/2/2022.
//

import Foundation

extension AppleMusicAPI {
    public struct TrackRelationship: Codable, Hashable {
        let data: [Song]
    }
}
