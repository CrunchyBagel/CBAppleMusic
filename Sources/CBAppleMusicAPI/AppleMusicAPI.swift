//
//  AppleMusicAPI.swift
//
//  Created by Quentin Zervaas on 1/3/19.
//

import Foundation
import CoreGraphics

public class AppleMusicAPI {
    public let developerToken: String
    public let countryCode: String

    public enum Error: LocalizedError {
        case invalidRequestData
        case invalidUserToken
        case invalidUrl
        case invalidMethod
        case invalidResponse
        case invalidResponseCode(Int)
        case missingKey(String)
    }

    enum ApiCall {
        case charts
        case search
        case playlists
        case recommendations
        case libraryPlaylists

        var urlFragment: String {
            switch self {
            case .charts: return "catalog/CC/charts"
            case .search: return "catalog/CC/search"
            case .playlists: return "catalog/CC/playlists"
            case .recommendations: return "me/recommendations"
            case .libraryPlaylists: return "me/library/playlists"
            }
        }
    }

    public init(developerToken: String, countryCode: String) {
        self.developerToken = developerToken
        self.countryCode = countryCode
    }

    func baseComponents(apiCall: ApiCall, pathComponents: [String] = []) -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.music.apple.com"

        let fragment = apiCall.urlFragment.replacingOccurrences(of: "/CC/", with: "/\(self.countryCode)/")

        let parts: [String] = [ "v1", fragment ] + pathComponents

        components.path = "/" + parts.joined(separator: "/")

        return components
    }

    func performRequest<T: Decodable>(type: T.Type, request: URLRequest, completion: @escaping (Result<T, Swift.Error>) -> Void) {

        let session = URLSession.shared

        let task = session.dataTask(with: request) { data, response, error in
            if let data = data, let str = String(data: data, encoding: .utf8) {
                print(str)
            }

            do {
                guard let response = response as? HTTPURLResponse else {
                    throw Error.invalidResponse
                }

                switch response.statusCode {
                case 200:
                    break
                default:
                    throw Error.invalidResponseCode(response.statusCode)
                }

                guard let data = data else {
                    throw Error.invalidResponse
                }

                let decoder = Self.createDecoder()

                let decoded = try decoder.decode(T.self, from: data)
                completion(.success(decoded))
            }
            catch {
                completion(.failure(error))
            }

        }

        task.resume()
    }

    public static func createDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return decoder
    }

    func performRequest<T: Decodable>(type: T.Type, urlComponents: URLComponents, userToken: String?, completion: @escaping (Result<T, Swift.Error>) -> Void) {
        guard let url = urlComponents.url else {
            completion(.failure(Error.invalidUrl))
            return
        }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(self.developerToken)", forHTTPHeaderField: "Authorization")

        if let userToken = userToken {
            request.setValue(userToken, forHTTPHeaderField: "Music-User-Token")
        }

        self.performRequest(type: T.self, request: request) { result in
            switch result {
            case .failure(let error):
                if let error = error as? Error {
                    switch error {
                    case .invalidResponseCode(let code):
                        if code == 403 && userToken != nil {
                            completion(.failure(Error.invalidUserToken))
                            return
                        }
                    default:
                        break
                    }
                }

                completion(.failure(error))

            case .success:
                completion(result)
            }
        }
    }
}


