//
//  Artwork.swift
//  
//
//  Created by Quentin Zervaas on 24/2/2022.
//

#if canImport(UIKit)
import UIKit
#endif

extension AppleMusicAPI {
    public struct Artwork: Codable, Hashable {
        let url: String? // URL string with placeholders so not necessarily parseable
        let width: Int?
        let height: Int?
    }
}

#if canImport(UIKit)
extension AppleMusicAPI.Artwork {
    public func url(size: CGSize, scale: CGFloat) -> URL? {
        guard let url = self.url else {
            return nil
        }

        let totalSize = CGSize(width: size.width * scale, height: size.height * scale)

        // {w}x{h}cc.jpeg

        var urlString = url.replacingOccurrences(of: "{w}", with: String(format: "%01.0f", totalSize.width))

        urlString = urlString.replacingOccurrences(of: "{h}", with: String(format: "%01.0f", totalSize.height))

        return URL(string: urlString)
    }
}
#endif
