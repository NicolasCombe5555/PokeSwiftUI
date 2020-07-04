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
        NavigationView {
            List(networkManager.pokemons) { pokemon in
                NavigationLink(destination: DetailView(url: pokemon.url, name: pokemon.name.capitalized)) {
                    Text(String(pokemon.name.capitalized))
                        .font(.callout)
                }
            }
            .navigationBarTitle("PokeSwiftUI")
        }
        .onAppear {
            self.networkManager.fetchPokemons()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
