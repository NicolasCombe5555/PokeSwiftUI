//
//  Pokemon.swift
//  PokeSwiftUI
//
//  Created by nicolasCombe on 11/3/19.
//  Copyright © 2019 Nicolas Combe. All rights reserved.
//

struct Response: Decodable {
    let results: [PokemonRaw]
}

struct PokemonRaw: Decodable, Identifiable {
    var id: String {
        return name
    }
    let name: String
    let url: String
}

struct DetailedPokemon: Decodable {
    
}
