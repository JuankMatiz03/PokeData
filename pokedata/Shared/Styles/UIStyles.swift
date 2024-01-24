//
//  UIStyles.swift
//  pokedata
//
//  Created by Camiilo on 21/01/24.
//

import Foundation
import SwiftUI

/// Estilos de manejo Global para la aplicacion
struct UIStyles {
    private struct Styles {
        // Estilo el logo
        static let logo = Font.system(size: 50)
        // Estilo para la fuente headline
        static let headline = Font.headline
        // Estilo para la fuente body
        static let body = Font.body
        // Estilo global de la app
        static let colorGlobal = Color(hex: "FC7CFF")
        // Estilo secundario de la app
        static let secondaryColor = Color(hex: "676767")
        // Estilo para texto de error
        static let colorError = Color.red
    }
    
    static let logoStyle: Font = Styles.logo
    static let headlineStyle: Font = Styles.headline
    static let bodyStyle: Font = Styles.body
    static let globalColor: Color = Styles.colorGlobal
    static let colorError: Color = Styles.colorError
    static let secondaryColor = Styles.secondaryColor
}
