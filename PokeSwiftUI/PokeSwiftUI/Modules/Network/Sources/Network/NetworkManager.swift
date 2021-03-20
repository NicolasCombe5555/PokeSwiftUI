//
//  NetworkManager.swift
//  PokeSwiftUI
//
//  Created by nicolasCombe on 11/3/19.
//  Copyright © 2019 Nicolas Combe. All rights reserved.
//

import Combine
import Foundation

public final class NetworkManager: ObservableObject {

    public static let shared = NetworkManager()
    public static let baseImageURL: URL = "https:raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"

    @Published
    public var pokemons = [PokemonRaw]()
    @Published
    public var pokemon: DetailedPokemon?

    private var cancellables = Set<AnyCancellable>()
    private let limit = 50

    private init() { }

    public func fetchPokemons() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: Response.self, decoder: JSONDecoder())
            .map(\.results)
            .assertNoFailure()
            .assign(to: \.pokemons, on: self)
            .store(in: &cancellables)
    }

    public func fetchPokemonDetails(withURL url: String) {
        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: DetailedPokemon.self, decoder: JSONDecoder())
            .assertNoFailure()
            .sink(receiveValue: { [weak self] in self?.pokemon = $0 })
            .store(in: &cancellables)
    }

}
