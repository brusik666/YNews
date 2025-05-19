//
//  ThumbnailView.swift
//  YNews
//
//  Created by Brusik on 5/12/25.
//

import SwiftUI

struct NewsThumbnailView: View {
    
    private let imageUrlString: String
    
    init(imageUrlString: String) {
        self.imageUrlString = imageUrlString
    }
    var body: some View {
        
        GeometryReader { geo in
            let imageSide = geo.size.width * 0.3
            
            let imageUrl = URL(string: imageUrlString)
            AsyncImage(url: imageUrl) { phase in
                
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: imageSide, height: imageSide)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: imageSide, height: imageSide)
                        .clipped()
                        .cornerRadius(8)
                case .failure(let error):
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageSide, height: imageSide)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
        }
        .frame(height: UIScreen.main.bounds.width * 0.3 + 8) // 8 — padding compensation

    }
}


#Preview {
    let imageStringUrl = ""
    NewsThumbnailView(imageUrlString: imageStringUrl)
}
