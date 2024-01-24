// CellView.swift
// pokedata
//
// Created by Camiilo on 21/01/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CellView: View {
    
    // MARK: - ViewModel
    
    @ObservedObject private var viewModel: CellViewModel
    
    /// Inicializador que recibe un objeto Pokemon
    /// - Parameters:
    ///   - pokemon: Modelo del pokemon
    
    init(pokemon: Pokemon) {
        self.viewModel = CellViewModel(pokemon: pokemon)
    }
    
    // MARK: - body
    
    var body: some View {
        RoundedRectangle(cornerRadius: 40)
            .fill(UIStyles.globalColor)
            .frame(height: 150)
            .overlay(
                ZStack(alignment: .bottom) {
                    VStack {
                        if let abilities = viewModel.abilities, !abilities.isEmpty {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Abilities:")
                                    .font(.system(size: 15))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                ForEach(abilities, id: \.self) { ability in
                                    Text("- \(ability.name)")
                                        .font(.system(size: 15))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        
                       // Vista que muestra la imagen del pokemon
                        PokemonImageView(url: viewModel.imageUrl)
                        
                        // Vista que muestra la información del pokemon
                        pokemonInfo
                    }
                }
            )
            .padding([.top, .bottom])
    }
        
    // Vista que muestra la informacion del pokemon, incluyendo habilidad
    private var pokemonInfo: some View {
        VStack {
            HStack {
                Spacer()
                
                Text("#\(viewModel.id)")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .foregroundColor(UIStyles.globalColor)
                    .padding()
                
                Spacer()
                
                Text(viewModel.name)
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.trailing, 30)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                
                Spacer()
            }
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(UIStyles.secondaryColor)
            )
            .offset(y: -100)
            
        }
    }

}

// MARK: - CellView_Previews

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        let simulatedPokemon = Pokemon(name: "bulbasaur",
                                       url: "https://pokeapi.co/api/v2/pokemon/6/")
        CellView(pokemon: simulatedPokemon)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
