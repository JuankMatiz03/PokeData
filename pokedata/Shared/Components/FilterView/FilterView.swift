//
//  FilterView.swift
//  pokedata
//
//  Created by Camiilo on 21/01/24.
//

import SwiftUI

/// Vista para realizar un filtrado de pokemones
struct FilterView: View {
    
    // MARK: - StateFilter
    
    @ObservedObject var filterState: FilterState
    var onSearchChanged: (() -> Void)?

    // MARK: - body
    
    var body: some View {
        TextField("Buscar Pokémon", text: $filterState.searchText, onEditingChanged: { _ in
            onSearchChanged?()
        })
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding(.horizontal)
        .padding(.bottom, 10)
        .overlay(
            HStack {
                Spacer()
                Image("LogoTwo")
                    .foregroundColor(.gray)
                    .padding(.trailing, 100)
                    .padding(.bottom, 30)
                    .frame(width: 5, height: 5)
                    .scaledToFill()
            }
        )
        .onReceive(filterState.$searchText.debounce(for: .seconds(0.5), scheduler: RunLoop.main)) { _ in
                      filterState.onSearchChanged.send()
        }
    }
}

// MARK: - FilterView_Previews

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        let filterState = FilterState()

        return FilterView(filterState: filterState)
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
