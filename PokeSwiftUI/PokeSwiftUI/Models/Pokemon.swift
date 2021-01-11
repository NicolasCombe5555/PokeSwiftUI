//
//  Pokemon.swift
//  PokeSwiftUI
//
//  Created by nicolasCombe on 11/3/19.
//  Copyright © 2019 Nicolas Combe. All rights reserved.
//

// MARK: - All pokemons
struct Response: Decodable {
    let results: [PokemonRaw]
}

struct PokemonRaw: Decodable, Identifiable {
    var id: String { name }
    let name: String
    let url: String
}

// MARK: - Detailed Information
struct DetailedPokemon: Decodable {
    let id: Int
    let sprites: Sprite
    let types: [Types]
}

struct Sprite: Decodable {
    let front_default: String?
}

struct Types: Decodable, Identifiable {
    var id: Int { slot }
    let slot: Int
    let type: Type
}

struct Type: Decodable {
    let name: String
    let url: String
}
