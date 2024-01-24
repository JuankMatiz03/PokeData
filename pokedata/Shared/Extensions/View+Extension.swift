//
//  View+Extension.swift
//  pokedata
//
//  Created by Camiilo on 20/01/24.
//

import Foundation
import SwiftUI

extension View {
    
    /// Convierte la vista actual a un AnyView
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
}
