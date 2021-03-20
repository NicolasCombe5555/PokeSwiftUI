//
//  DetailView.swift
//  PokeSwiftUI
//
//  Created by nicolasCombe on 11/3/19.
//  Copyright © 2019 Nicolas Combe. All rights reserved.
//

import SwiftUI
import Network

struct DetailView: View {
    @ObservedObject var networkManager = NetworkManager.shared

    let url: String
    let imageURL: URL
    let name: String

    var body: some View {
        VStack {
            Text(name)
                .font(.title)

            AsyncImage(
                imageLoader: ImageLoaderCache.shared.loaderFor(url: imageURL),
                size: CGSize(width: 200, height: 200)
            )

            HStack {
                ForEach(networkManager.pokemon?.types ?? [Types]()) { type in
                    Image("s_\(type.type.name)")
                }
            }

            Spacer()
        }
        .redacted(reason: networkManager.pokemon == nil ? .placeholder : [])
        .onAppear { networkManager.fetchPokemonDetails(withURL: url) }
        .onDisappear { networkManager.pokemon = nil }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(
            url: "https://pokeapi.co/api/v2/pokemon/1",
            imageURL: NetworkManager.baseImageURL.appendingPathComponent("1.png"),
            name: "Bulbasaur"
            )
    }
}
