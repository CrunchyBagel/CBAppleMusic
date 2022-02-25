//
//  ContentRating.swift
//  
//
//  Created by Quentin Zervaas on 9/6/20.
//

import Foundation
import CoreGraphics


extension AppleMusicAPI {
    public enum ContentRating: String, Codable, Hashable {
        case clean
        case explicit
    }
}
