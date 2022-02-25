//
//  Recommendations.swift
//  
//
//  Created by Quentin Zervaas on 25/2/2022.
//

import Foundation

extension AppleMusicAPI {
    public func myRecommendations(userToken: String, type: AppleMusicAPI.ResourceType?, limit: Int?, completion: @escaping (Result<[AppleMusicAPI.Recommendation], Swift.Error>) -> Void) {
        var components = self.baseComponents(apiCall: .recommendations)

        var queryItems: [URLQueryItem] = []

        if let type = type {
            queryItems.append(URLQueryItem(name: "type", value: type.rawValue))
        }

        if let limit = limit {
            queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"))
        }

        if queryItems.count > 0 {
            components.queryItems = queryItems
        }

        self.performRequest(type: RecommendationResponse.self, urlComponents: components, userToken: userToken) { result in

            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

