//
//  FilterState.swift
//  pokedata
//
//  Created by Camiilo on 21/01/24.
//

import Foundation
import Combine

/// Representa el estado del Filtro
class FilterState: ObservableObject {
    @Published var searchText: String = ""
    let onSearchChanged = PassthroughSubject<Void, Never>()
}
