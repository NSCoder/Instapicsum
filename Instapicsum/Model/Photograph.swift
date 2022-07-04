//
//  Photograph.swift
//  Instapicsum
//
//  Created by Iker Karam on 7/4/22.
//

import Foundation

typealias PhotographID = String

struct Photograph: Identifiable {
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

    var orientation: Orientation {
        width > height ? .landscape : .portrait
    }
}
