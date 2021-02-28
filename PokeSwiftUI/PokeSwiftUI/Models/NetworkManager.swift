//
//  NetworkManager.swift
//  PokeSwiftUI
//
//  Created by nicolasCombe on 11/3/19.
//  Copyright © 2019 Nicolas Combe. All rights reserved.
//

import Foundation

final class NetworkManager: ObservableObject {

    @Published var pokemons = [PokemonRaw]()
    @Published var pokemon: DetailedPokemon?

    static let shared = NetworkManager()
    private init() { }

    func fetchPokemons() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=25") else { return }
        
        URLSession(configuration: .default).dataTask(with: url) { (data, _, error) in
            if let error = error { print(error.localizedDescription); return }

            if let safeData = data {
                do {
                    let decoder = JSONDecoder()
                    let results = try decoder.decode(Response.self, from: safeData)
                    DispatchQueue.main.async { self.pokemons = results.results }
                } catch {
                    print(error.localizedDescription)
                }
            }

        }.resume()
    }

    func fetchPokemonDetails(withURL url: String) {
        guard let url = URL(string: url) else { return }

        URLSession(configuration: .default).dataTask(with: url) { (data, _, error) in
            if let error = error { print(error.localizedDescription) }

            if let safeData = data {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(DetailedPokemon.self, from: safeData)
                    DispatchQueue.main.async { self.pokemon = result }
                } catch {
                    print(error.localizedDescription)
                }
            }
            
        }.resume()
    }

}
