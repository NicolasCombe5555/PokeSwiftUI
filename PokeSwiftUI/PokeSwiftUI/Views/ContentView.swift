//
//  ContentView.swift
//  PokeSwiftUI
//
//  Created by nicolasCombe on 11/3/19.
//  Copyright © 2019 Nicolas Combe. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager.shared

    var body: some View {
        pokemons
    }

    private var pokemons: some View {
        NavigationView {
            List(networkManager.pokemons.enumeratedArray(), id: \.offset) { (index, pokemon) in
                let imageURL = NetworkManager.baseImageURL.appendingPathComponent("\(index+1).png")

                NavigationLink(destination: DetailView(
                    url: pokemon.url,
                    imageURL: imageURL,
                    name: pokemon.name.capitalized)
                ) {
                    HStack {
                        AsyncImage(
                            imageLoader: ImageLoaderCache.shared.loaderFor(url: imageURL),
                            size: CGSize(width: 50, height: 50)
                        )

                        Text(String(pokemon.name.capitalized))
                            .font(.callout)
                    }
                }
            }
            .navigationBarTitle("PokeSwiftUI")
        }
        .onAppear {
            networkManager.fetchPokemons()
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
