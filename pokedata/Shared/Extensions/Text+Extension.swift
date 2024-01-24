//
//  Text+Extension.swift
//  pokedata
//
//  Created by Camiilo on 20/01/24.
//

import Foundation
import SwiftUI

extension Text {
    
    /// Estilos de texto
    func headlineStyle() -> some View {
        self
            .font(UIStyles.headlineStyle)
            .font(.system(size: 20))
            .foregroundColor(UIStyles.colorError)
     }
    
    /// Estilos de texto
    func bodyStyle() -> Text {
        self
            .font(UIStyles.bodyStyle)
            .foregroundColor(UIStyles.colorError)
    }
    
}
