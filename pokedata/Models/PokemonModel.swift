//
//  PokemonModel.swift
//  pokedata
//
//  Created by Camiilo on 20/01/24.
//

import Foundation

// Estructura que representa la lista de pokem en la respuesta de la API
struct PokemonList: Decodable {
    let results: [Pokemon]
}

// Estructura que representa un pokemon en la respuesta de la API
struct Pokemon: Identifiable, Codable, Equatable {
    let name: String
    let url: String
    var abilities: [Ability]? 
    
    // Calcula el ID del pojkemon extrayendolo de la URL
    var id: Int? {
        return Int(url.split(separator: "/").last?.description ?? "0")
    }
    
    // Calcula la URL de la imagen del pokemon basandose en su ID
    var imageUrl: URL? {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id ?? 0).png")
    }
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id
    }
}
