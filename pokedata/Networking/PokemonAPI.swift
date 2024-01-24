//
//  PokemonAPI.swift
//  pokedata
//
//  Created by Camiilo on 20/01/24.
//

//
//  PokemonAPI.swift
//  pokedata
//
//  Created by Camiilo on 20/01/24.
//

import Foundation
import Alamofire
import Combine

// Protocolo que define la carga de la lista de pokemones
protocol PokemonLoader {
    func fetchPokemon(offset: Int, limit: Int) -> AnyPublisher<[Pokemon], Error>
}

// Servicio que realiza la consulta de los pokemones
final class PokemonApi: PokemonLoader {
   
    private let baseURL: String
   
    /// Inicializador personalizado para la vista de error.
    /// - Parameters:
    ///   - baseURL: Url del servicio

    init(baseURL: String = "https://pokeapi.co/api/v2/") {
        self.baseURL = baseURL
    }

    // Metodo para obtener los pokemones
    func fetchPokemon(offset: Int, limit: Int) -> AnyPublisher<[Pokemon], Error> {
        let url = baseURL + "pokemon?offset=\(offset)&limit=\(limit)"
        
        return AF.request(url)
            .publishDecodable(type: PokemonList.self)
            .tryMap { response in
                guard let pokemonList = response.value else {
                    throw AFError.responseValidationFailed(reason: .dataFileNil)
                }
                return pokemonList.results
            }
            .eraseToAnyPublisher()
    }
}
