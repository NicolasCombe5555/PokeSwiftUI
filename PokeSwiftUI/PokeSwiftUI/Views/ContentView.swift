//
//  ContentView.swift
//  PokeSwiftUI
//
//  Created by nicolasCombe on 11/3/19.
//  Copyright © 2019 Nicolas Combe. All rights reserved.
//

import SwiftUI

let baseUrlString = "https:raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"

struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager.shared

    var body: some View {
        pokemons
    }

    private var pokemons: some View {
        NavigationView {
            List(networkManager.pokemons) { pokemon in
                NavigationLink(destination: DetailView(url: pokemon.url, name: pokemon.name.capitalized)) {
                    HStack {
                        AsyncImage(imageLoader: ImageLoader(url: URL(string: baseUrlString + "\(1).png")!))
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
