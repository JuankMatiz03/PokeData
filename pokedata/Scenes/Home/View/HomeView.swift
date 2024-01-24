//
//  HomeView.swift
//  pokedata
//
//  Created by Camiilo on 20/01/24.
//

import SwiftUI

/// La vista principal que contiene un TabView con dos pestañas.
/// Lista de pokemones y lista de favoritos
struct HomeView: View {
    
    // MARK: - ListViewModel
    
    @StateObject var listViewModel = ListViewModel(pokemonLoader: PokemonApi(),
                                                   filterService: FilterService())
    
    // MARK: - body
    
    var body: some View {
         NavigationView {
             ScrollView {
                 VStack {
                     Image("PokeLogo")
                         .resizable()
                         .scaledToFit()
                         .frame(width: 300, height: 300)
                         .padding()
                     
                     NavigationLink(destination: ListView(viewModel: listViewModel)) {
                         CardView(viewModel: CardViewModel(title: "Lista de pokemones", imageName: "dash"))
                     }
                     .buttonStyle(PlainButtonStyle())
                 }
                 .frame(maxWidth: .infinity, maxHeight: .infinity)
                 .padding()
             }
         }
     }
}

// MARK: - HomeView_Previews

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
