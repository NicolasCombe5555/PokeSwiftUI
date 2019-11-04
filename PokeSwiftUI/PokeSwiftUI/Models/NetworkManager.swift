//
//  NetworkManager.swift
//  PokeSwiftUI
//
//  Created by nicolasCombe on 11/3/19.
//  Copyright © 2019 Nicolas Combe. All rights reserved.
//

import Foundation

class NetworkManager: ObservableObject {
    
    static let shared = NetworkManager()
    private init() { }
    
    @Published var pokemons = [PokemonRaw]()
    @Published var pokemon: DetailedPokemon?
    
    func fetchPokemons() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?offset=20&limit=964#") else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
                let decoder = JSONDecoder()
                if let safeData = data {
                    do {
                        let results = try decoder.decode(Response.self, from: safeData)
                        DispatchQueue.main.async {
                            self.pokemons = results.results
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            
        }
        task.resume()
    }
    
    func fetchPokemonDetails(for pokemonID: String) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemonID)") else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
                let decoder = JSONDecoder()
                if let safeData = data {
                    do {
                        let result = try decoder.decode(DetailedPokemon.self, from: safeData)
                        DispatchQueue.main.async {
                            self.pokemon = result
                            print(self.pokemon)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            
        }
        task.resume()
    }
}
