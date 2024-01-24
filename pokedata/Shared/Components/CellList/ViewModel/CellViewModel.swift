//
//  CellViewModel.swift
//  pokedata
//
//  Created by Camiilo on 21/01/24.
//

import Foundation

/// ViewModel para CellList
class CellViewModel: ObservableObject {
        
    @Published private var pokemon: Pokemon

    /// Inicializador personalizado para  CellList.
    /// - Parameters:
    ///   - pokemon: Pokemon a mostrar
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }

    /// retorna el id del pokemon
    var id: String {
        return pokemon.id?.description ?? "**"
    }

    /// retorna el nombre del pokemon
    var name: String {
        return pokemon.name.capitalized 
    }

    /// retorna ela imagen del pokemon
    var imageUrl: URL? {
        return pokemon.imageUrl
    }
    
    /// retorna las habilidades del pokemon
    var abilities: [Ability]? {
        return pokemon.abilities
    }
    
}
