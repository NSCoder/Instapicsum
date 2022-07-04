//
//  ImageProvider.swift
//  Instapicsum
//
//  Created by Iker Karam on 7/4/22.
//

import Foundation
import SwiftUI

/// Defines the necessary functionality to obtain thumbnails
/// and images for a given `Photograph`
protocol ImageProvider {
    /// Return a thumbnail image of a `Photograph`
    func thumbnailImage(for photograph: Photograph) async throws -> UIImage

    /// Return the full resolution image of a `Photograph`
    func image(for photograph: Photograph) async throws -> UIImage
}
