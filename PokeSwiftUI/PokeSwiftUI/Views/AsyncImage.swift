//
//  AsyncImage.swift
//  AsyncImage
//
//  Created by Vadym Bulavin on 2/13/20.
//  Copyright © 2020 Vadym Bulavin. All rights reserved.
//

import SwiftUI

struct AsyncImage: View {

    @ObservedObject var imageLoader: ImageLoader
    
    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                LoadingView()
            }
        }
        .frame(width: 50, height: 50, alignment: .center)
    }

}
