//
//  DetailView.swift
//  PokeSwiftUI
//
//  Created by nicolasCombe on 11/3/19.
//  Copyright © 2019 Nicolas Combe. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    let url: String
    let name: String
    
    @ObservedObject var networkManager = NetworkManager.shared
    
    var body: some View {
        VStack {
            Text(name)
                .font(.title)
            
            WebView(urlString: networkManager.pokemon.sprites.front_default)
                .frame(width: 300, height: 100, alignment: .center)
            
            Text("Pokedex id: \(networkManager.pokemon.id )")
                .font(.subheadline)
            
            HStack {
                ForEach(networkManager.pokemon.types) { type in
                    Image("s_\(type.type.name)")
                }
            }
            
            Spacer()
        }
        .onAppear() {
            self.networkManager.fetchPokemonDetails(withURL: self.url)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://pokeapi.co/api/v2/pokemon/21", name: "Spearow")
    }
}
