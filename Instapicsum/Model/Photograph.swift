//
//  Photograph.swift
//  Instapicsum
//
//  Created by Iker Karam on 7/4/22.
//

import Foundation

typealias PhotographID = String

/// Represents the metadata for an photographic image
struct Photograph: Identifiable, Decodable {
    enum Orientation {
        case landscape
        case portrait
    }

    let id: PhotographID
    let author: String
    let width: Int
    let height: Int
    let url: URL
    let downloadURL: URL

    enum CodingKeys: String, CodingKey {
        case id
        case author
        case width
        case height
        case url
        case downloadURL = "download_url"
    }

    /// Photograph Orientation
    var orientation: Orientation {
        width > height ? .landscape : .portrait
    }
}
