//
//  FilterService.swift
//  pokedata
//
//  Created by Camiilo on 21/01/24.
//

import Foundation

/// Servicio para realizar un filtrado a la lista de componentes
class FilterService {
    
    // filtrado de pokemones
    func applyFilter(to pokemons: [Pokemon], searchText: String) -> [Pokemon] {
        guard !searchText.isEmpty else {
            return pokemons
        }

        let filteredPokemons = pokemons.filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }

        return filteredPokemons.isEmpty ? pokemons : filteredPokemons
    }
}
