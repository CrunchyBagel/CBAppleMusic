//
//  AppleMusicAPI+Error.swift
//  
//
//  Created by Quentin Zervaas on 28/2/2022.
//

import Foundation

extension AppleMusicAPI {
    public enum Error: Swift.Error {
        case invalidRequestData
        case invalidUserToken
        case invalidUrl
        case invalidMethod
        case invalidResponse
        case invalidResponseCode(Int)
        case missingKey(String)
    }
}
