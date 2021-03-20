//
//  AsyncImage.swift
//  AsyncImage
//
//  Created by Vadym Bulavin on 2/13/20.
//  Copyright © 2020 Vadym Bulavin. All rights reserved.
//

import SwiftUI
import Network

struct AsyncImage: View {

    @ObservedObject var imageLoader: ImageLoader
    let size: CGSize
    
    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                LoadingView()
            }
        }
        .frame(width: size.width, height: size.height)
    }

}
