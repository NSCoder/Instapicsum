//
//  PhotographCollectionView.swift
//  Instapicsum
//
//  Created by Iker Karam on 7/4/22.
//

import SwiftUI

struct PhotographCollectionView: View {
    @EnvironmentObject var photographStore: PhotographStore
    @State private var photographs: [Photograph] = []
    @State private var nextPhotographPage: PageNumber = 1

    func loadNextPhotographPage() {
        Task.detached {
            let photographs = try await photographStore.photographs(for: nextPhotographPage)
            await MainActor.run {
                self.photographs.append(contentsOf: photographs)
                nextPhotographPage += 1
            }
        }
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [.init(), .init(), .init()]) {
                ForEach($photographs) { $photograph in
                    NavigationLink(destination: PhotographView(photograph: $photograph)) {
                        PhotographTileView(photograph: $photograph)
                            .frame(width: 100, height: 100)
                    }
                }
                ProgressView()
                    .frame(width: 100, height: 100)
                    .onAppear {
                        loadNextPhotographPage()
                    }
            }
        }
        .navigationTitle("Instapicsum")
    }
}

struct PhotographCollectionView_Previews: PreviewProvider {
    static let photographStore = PhotographStore()
    static let imageStore = ImageStore()
    static var previews: some View {
        NavigationView {
            PhotographCollectionView()
        }
        .environmentObject(photographStore)
        .environmentObject(imageStore)
    }
}
