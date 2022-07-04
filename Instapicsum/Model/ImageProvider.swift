//
//  ImageProvider.swift
//  Instapicsum
//
//  Created by Iker Karam on 7/4/22.
//

import Foundation
import SwiftUI

protocol ImageProvider {
    func thumbnailImage(for photograph: Photograph) async throws -> Image
    func image(for photograph: Photograph) async throws -> Image
}
