//
//  PhotographView.swift
//  Instapicsum
//
//  Created by Iker Karam on 7/4/22.
//

import SwiftUI

struct PhotographView: View {
    @EnvironmentObject var imageStore: ImageStore
    @Binding var photograph: Photograph

    @State private var image: UIImage? = nil

    var contentMode: ContentMode {
        if photograph.orientation == .landscape {
            return .fit
        }
        return .fill
    }

    func loadImage() {
        Task.detached {
            let image = try await imageStore.image(for: photograph)
            await MainActor.run {
                self.image = image
            }
        }
    }

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .accessibilityIdentifier(photograph.id)
                HStack() {
                    Text(photograph.author)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                    Spacer()
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            loadImage()
        }
    }
}

struct PhotographView_Previews: PreviewProvider {
    static let imageStore = ImageStore()
    static let photographCollection = StaticPhotographCollectionProvider()

    static var previews: some View {
        let portraitPhotograph = try! photographCollection.anyPortraitPhotograph()
        let landscapePhotograph = try! photographCollection.anyLandscapePhotograph()

        Group {
            NavigationView {
                PhotographView(photograph: .constant(portraitPhotograph))
            }

            NavigationView {
                PhotographView(photograph: .constant(landscapePhotograph))
            }
        }
        .environmentObject(imageStore)
    }
}
