//
//  Photo.swift
//  Chapter2 (iOS)
//
//  Created by Lukáš Hromadník on 11/07/2020.
//

import UIKit

struct Photo {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: URL
    let downloadURL: URL
}

extension Photo {
    func thumbnailURL(width: Int) -> URL {
        var components = URLComponents()
        components.scheme = downloadURL.scheme
        components.host = downloadURL.host
        
        var pathComponents = downloadURL.pathComponents[1...2]
        pathComponents.append("\(width)")
        components.path = "/" + pathComponents.joined(separator: "/")
        
        guard let thumbnailURL = components.url else {
            assertionFailure()
            return downloadURL
        }
        
        return thumbnailURL
    }
}

extension Photo: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case author
        case width
        case height
        case url
        case downloadURL = "download_url"
    }
}

extension Photo: Identifiable, Hashable { }
