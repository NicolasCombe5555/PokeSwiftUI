//
//  Pokemon.swift
//  PokeSwiftUI
//
//  Created by nicolasCombe on 11/3/19.
//  Copyright © 2019 Nicolas Combe. All rights reserved.
//

//All pokemons
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

// Detailed Information
struct DetailedPokemon: Decodable {
    let id: Int
    let sprites: Sprite
    let types: [Types]
}

struct Sprite: Decodable {
    let front_default: String?

}

struct Types: Decodable {
    let slot: Int
    let type: Type
}

struct Type: Decodable {
    let name: String
    let url: String
}
