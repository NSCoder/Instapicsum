//
//  StaticProviderError.swift
//  Instapicsum
//
//  Created by Iker Karam on 7/4/22.
//

import Foundation

enum StaticProviderError: Error {
    case unableToLoadAsset(named: String)
}
