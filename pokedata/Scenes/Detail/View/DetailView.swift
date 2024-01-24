//
//  DetailView.swift
//  pokedata
//
//  Created by Camiilo on 20/01/24.
//

import SwiftUI

/// Vista para el detalle del pokemon
struct DetailView: View {
    
    // MARK: - ViewModel
    
    @ObservedObject var viewModel: DetailViewModel
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    imageLogo
                    Spacer()
                    pokemonInfoTop
                    contentImage
                    habilitesText
                    contentDescription
                }
            }
        }
        .padding([.vertical, .horizontal])
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
    
    // Se retorna un vista de Image
    private var imageLogo: some View {
        Image("PokeLogo")
            .padding(.top, 10)
    }
    
    // Se retorna un vista de Image en un contenedor
    private var contentDescription: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(UIStyles.globalColor)
            .frame(height: 200) 
            .overlay(
                PokemonImageView(url: viewModel.pokemon.imageUrl))
            .padding([.top, .bottom])
    }
    
    // Se retorna un vista de Image en un contenedor
    private var contentImage: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(UIStyles.globalColor)
            .frame(height: 150)
            .overlay(
                PokemonImageView(url: viewModel.pokemon.imageUrl)
            )
            .padding([.top, .bottom])
    }
    
    // Se retorna un vista habilidades
    private var habilitesText: some View {
        HStack {
            Text("Habilidades")
        }
        .padding(.top, 15)
    }
    
    // Se retorna un vista con la informacion superior del pokemon
    // ID del pokemon
    // Nombre del pokemon
    private var pokemonInfoTop: some View {
        HStack {
            
            Spacer()
            
            Text("#001")
                .font(.system(size: 15))
                .fontWeight(.bold)
                .foregroundColor(UIStyles.globalColor)
                .padding()
            
            Spacer()
            
            Text(viewModel.pokemon.name)
                .font(.system(size: 15))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
            
            Spacer()
        }
        .padding(.top, 50)
    }
}

// MARK: - DetailView_Previews

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let samplePokemon = Pokemon(name: "pikachu",
                                    url: "https://pokeapi.co/api/v2/pokemon/25/")
        let viewModel = DetailViewModel(pokemon: samplePokemon)
        return DetailView(viewModel: viewModel)
    }
}

