//
//  Picsum.swift
//  Instapicsum
//
//  Created by Iker Karam on 7/4/22.
//

import Foundation

// Not initializable
enum Picsum {
    // swiftlint:disable:next force_unwrapping
    /// Base url for Picsum service
    static var baseURL: URL = URL(string: "https://picsum.photos")!

    /// Number of photographs to fetch per collection page
    static var photographsPerPage: Int = 50

    /// Size of  the thumbnail images
    static var thumbnailSize: Int = 300
}
