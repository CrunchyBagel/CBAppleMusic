//
//  AppleMusicAPI.swift
//
//  Created by Quentin Zervaas on 1/3/19.
//

import Foundation
import CoreGraphics
import OSLog

public final class AppleMusicAPI: Sendable {
    public let apiKey: APIKey
    public let countryCode: CountryCode

    public init(apiKey: APIKey, countryCode: CountryCode) {
        self.apiKey = apiKey
        self.countryCode = countryCode
    }
}

extension AppleMusicAPI {
    enum ApiCall {
        case charts
        case search
        case playlists
        case recommendations
        case libraryPlaylists

        func urlFragment(countryCode: CountryCode) -> String {
            switch self {
            case .charts: return "catalog/\(countryCode.code)/charts"
            case .search: return "catalog/\(countryCode.code)/search"
            case .playlists: return "catalog/\(countryCode.code)/playlists"
            case .recommendations: return "me/recommendations"
            case .libraryPlaylists: return "me/library/playlists"
            }
        }

        func urlComponents(countryCode: CountryCode, pathComponents: [String] = []) -> URLComponents {
            var components = Self.baseComponents

            let allPathComponents: [String] = [
                "v1",
                urlFragment(countryCode: countryCode)
            ] + pathComponents

            components.path = "/" + allPathComponents.joined(separator: "/")

            return components
        }

        static var baseComponents: URLComponents {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.music.apple.com"

            return components
        }
    }

    func baseComponents(apiCall: ApiCall, pathComponents: [String] = []) -> URLComponents {
        apiCall.urlComponents(countryCode: self.countryCode, pathComponents: pathComponents)
    }

    func components(nextURL: String) -> URLComponents {
        var components = ApiCall.baseComponents
        components.path = nextURL

        return components
    }

    func performRequest<T: Decodable & Sendable>(
        type: T.Type,
        request: URLRequest,
        completion: @escaping @Sendable (Result<T, Swift.Error>) -> Void
    ) {

        let session = URLSession.shared
        
        os_log("AppleMusicAPI: %@ %@", request as CVarArg, String(describing: type.self))

        let task = session.dataTask(with: request) { data, response, error in
//            if let data = data, let str = String(data: data, encoding: .utf8) {
//                print(str)
//            }

            do {
                guard let response = response as? HTTPURLResponse else {
                    throw Error.invalidResponse
                }

                os_log("AppleMusicAPI: statusCode=%@", response.statusCode as NSNumber)

                switch response.statusCode {
                case 200:
                    break
                default:
                    throw Error.invalidResponseCode(response.statusCode)
                }

                guard let data = data else {
                    throw Error.invalidResponse
                }

                let decoder = Self.createResponseDecoder()

                let decoded = try decoder.decode(T.self, from: data)
                completion(.success(decoded))
            }
            catch {
                completion(.failure(error))
            }

        }

        task.resume()
    }

    public static func createResponseDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return decoder
    }

    func performRequest<T: Decodable & Sendable>(
        type: T.Type,
        urlComponents: URLComponents,
        userToken: String?,
        completion: @escaping @Sendable (Result<T, Swift.Error>) -> Void
    ) {
        guard let url = urlComponents.url else {
            completion(.failure(Error.invalidUrl))
            return
        }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(self.apiKey.key)", forHTTPHeaderField: "Authorization")

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

