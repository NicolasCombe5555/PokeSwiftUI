//
//  File.swift
//  
//
//  Created by nicolasCombe on 3/20/21.
//

// MARK: - All pokemons
internal struct Response: Decodable {
    internal let results: [PokemonRaw]
}

public struct PokemonRaw: Decodable {
    public let name: String
    public let url: String
}

extension PokemonRaw: Identifiable {
    public var id: String { name }
}

// MARK: - Detailed Information
public struct DetailedPokemon: Decodable {
    public let id: Int
    public let types: [Types]
}

public struct Types: Decodable {
    public let type: Type
    private let slot: Int
}

extension Types: Identifiable {
    public var id: Int { slot }
}

public struct Type: Decodable {
    public let name: String
}
