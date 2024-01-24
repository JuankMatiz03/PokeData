//
//  AbilityModel.swift
//  pokedata
//
//  Created by Camiilo on 22/01/24.
//

import Foundation

// Estructura que representa la respuesta de la API de habilidades
struct AbilityList: Decodable {
    let abilities: [Ability]
}

// Estructura que representa una habilidad
struct Ability: Codable, Equatable, Hashable {
    let name: String
}
