//
//  Pokemon.swift
//  PokeSwiftUI
//
//  Created by nicolasCombe on 11/3/19.
//  Copyright © 2019 Nicolas Combe. All rights reserved.
//

struct Response: Decodable {
    let pokemons: [PokemonRaw]
}

struct PokemonRaw: Decodable {
    let name: String
    let url: String
}

struct DetailedPokemon: Decodable {
    
}
