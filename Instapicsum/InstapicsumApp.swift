//
//  InstapicsumApp.swift
//  Instapicsum
//
//  Created by Iker Karam on 7/4/22.
//

import SwiftUI

@main
struct InstapicsumApp: App {
    let photographStore = PhotographStore()
    let imageStore = ImageStore()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                PhotographCollectionView()
            }
            .environmentObject(photographStore)
            .environmentObject(imageStore)
        }
    }
}
