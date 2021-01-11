//
//  DetailView.swift
//  PokeSwiftUI
//
//  Created by nicolasCombe on 11/3/19.
//  Copyright © 2019 Nicolas Combe. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var networkManager = NetworkManager.shared

    let url: String
    let name: String

    var body: some View {
        VStack {
            Text(name)
                .font(.title)
            WebView(urlString: networkManager.pokemon?.sprites.front_default)
                .frame(width: 300, height: 100, alignment: .center)

            HStack {
                ForEach(networkManager.pokemon?.types ?? [Types]()) { type in
                    Image("s_\(type.type.name)")
                }
            }
            Spacer()
        }
        .onAppear {
            networkManager.pokemon = nil
            networkManager.fetchPokemonDetails(withURL: url)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://pokeapi.co/api/v2/pokemon/21", name: "Spearow")
    }
}
