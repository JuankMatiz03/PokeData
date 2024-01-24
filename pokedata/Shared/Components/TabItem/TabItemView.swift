//
//  TabItemView.swift
//  pokedata
//
//  Created by Camiilo on 20/01/24.
//

import SwiftUI

/// Un componente reutilizable para representar un elemento de pestaña en un TabView.
struct TabItemView<Content: View>: View {
    
    let systemName: String
    let title: String
    let content: Content
    
    /// Inicializa el TabItemView con el nombre del sistema, el título y el contenido de la pestaña.
    /// @ViewBuilder permite que el contenido de la pestaña sea mas limpio y expresivo.
    /// - Parameters:
    ///   - systemName: El nombre del sistema del simbolo de la pestaña.
    ///   - title: El título de la pestaña.
    ///   - content: El contenido de la pestaña proporcionado mediante un cierre @ViewBuilder.

    init(systemName: String, title: String, @ViewBuilder content: () -> Content) {
        self.systemName = systemName
        self.title = title
        self.content = content()
    }
    
    // MARK: - Body

    var body: some View {
        content
            .tabItem {
                Image(systemName: systemName)
                    .imageScale(.large)
                Text(title)
                    .font(.caption)
            }
            .navigationBarHidden(true)
    }
}

