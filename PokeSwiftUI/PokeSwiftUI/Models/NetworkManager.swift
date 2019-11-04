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
    @Published var pokemon = DetailedPokemon(id: 123456, sprites: Sprite(front_default: nil), types: [Types(slot: 1, type: Type(name: "water", url: "123"))])
    
    func fetchPokemons() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?offset=0&limit=964#") else { return }
        
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
    
    func fetchPokemonDetails(with url: String) {
        guard let url = URL(string: url) else { return }
        
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
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            
        }
        task.resume()
    }
}
