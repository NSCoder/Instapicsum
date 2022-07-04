//
//  PhotographTileView.swift
//  Instapicsum
//
//  Created by Iker Karam on 7/4/22.
//

import SwiftUI

struct PhotographTileView: View {
    @EnvironmentObject var imageStore: ImageStore
    @Binding var photograph: Photograph

    @State private var thumbnail: UIImage? = nil

    func loadThumbnail() {
        Task.detached {
            let thumbnail = try await imageStore.thumbnailImage(for: photograph)
            await MainActor.run {
                self.thumbnail = thumbnail
            }
        }
    }

    var body: some View {
        VStack {
            if let thumbnail = thumbnail {
                Image(uiImage: thumbnail)
                    .resizable()
            } else {
                ProgressView()
            }
        }
        .accessibilityIdentifier(photograph.id)
        .onAppear {
            loadThumbnail()
        }
    }
}

struct PhotographTileView_Previews: PreviewProvider {
    static let photographCollection = StaticPhotographCollectionProvider()
    static let imageStore = ImageStore()
    static var previews: some View {
        let portraitPhotograph = try! photographCollection.anyPortraitPhotograph()
        let landscapePhotograph = try! photographCollection.anyLandscapePhotograph()

        return Group {
            PhotographTileView(photograph: .constant(portraitPhotograph))
            .frame(width: 100, height: 100)
            .previewDisplayName("Portrait")


            PhotographTileView(photograph: .constant(landscapePhotograph))
            .previewDisplayName("Landscape")
            .frame(width: 100, height: 100)
        }
        .previewLayout(.sizeThatFits)
        .previewDevice(.none)
        .environmentObject(imageStore)
    }
}
