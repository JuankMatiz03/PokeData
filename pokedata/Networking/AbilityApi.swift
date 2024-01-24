//
//  AbilityApi.swift
//  pokedata
//
//  Created by Camiilo on 22/01/24.
//

import Foundation
import Alamofire
import Combine


/// Protocolo de AbilityApi
protocol AbilityLoader {
    func fetchAbility(abilityURL: String) -> AnyPublisher<[Ability], Error>
}

/// Api para el retorno de habilidades
final class AbilityApi: AbilityLoader {
   
    private let baseURL: String
    
    /// Inicializador personalizado para la vista de error.
    /// - Parameters:
    ///   - baseURL: Url del servicio

    init(baseURL: String = "https://pokeapi.co/api/v2/") {
        self.baseURL = baseURL
    }
    
    // Metodo para las habilidades del pokemon
    func fetchAbility(abilityURL: String) -> AnyPublisher<[Ability], Error> {
        return AF.request(abilityURL)
            .publishDecodable(type: AbilityList.self)
            .tryMap { response in
                guard let abilityList = response.value else {
                    throw AFError.responseValidationFailed(reason: .dataFileNil)
                }
                return abilityList.abilities
            }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
