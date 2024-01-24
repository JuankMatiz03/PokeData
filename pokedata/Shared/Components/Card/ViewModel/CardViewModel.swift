//
//  CardViewModel.swift
//  pokedata
//
//  Created by Camiilo on 21/01/24.
//

import Foundation
import SwiftUI

/// ViewModel para la vista CardView
class CardViewModel: ObservableObject {
    
    @Published var title: String
    @Published var imageName: String
    
    /// - Parameters:
    ///   - title: titulo del pokemon.
    ///   - imageName: imagen del pokemon

    init(title: String, imageName: String) {
        self.title = title
        self.imageName = imageName
    }
}
