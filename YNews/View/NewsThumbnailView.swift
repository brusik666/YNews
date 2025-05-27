//
//  ThumbnailView.swift
//  YNews
//
//  Created by Brusik on 5/12/25.
//

import SwiftUI

struct NewsThumbnailView: View {
    let imageUrlString: String
    private let aspectRatio: CGFloat = 4 / 3

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = width / aspectRatio

            AsyncImage(url: URL(string: imageUrlString)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                        .clipped()
                        .cornerRadius(8)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: width, height: height)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
        }
        .aspectRatio(aspectRatio, contentMode: .fit)
    }
}



#Preview {
    let imageStringUrl = "https://picsum.photos/400/200"
    NewsThumbnailView(imageUrlString: imageStringUrl)
}
