//
//  DetailViewModel.swift
//  pokedata
//
//  Created by Camiilo on 20/01/24.
//

import Foundation

class DetailViewModel: ObservableObject {
    
    @Published var pokemon: Pokemon
    
    /// Inicializa el DetailViewModel con el  pokemon
    /// - Parameters:
    ///   - pokemon: Modelo del pokemon
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    
    
}
