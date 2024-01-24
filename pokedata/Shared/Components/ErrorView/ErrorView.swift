//
//  ErrorView.swift
//  pokedata
//
//  Created by Camiilo on 20/01/24.
//

import SwiftUI

// MARK: - ErrorView

/// Una vista reutilizable para mostrar mensajes de error.
struct ErrorView: View {
    
    let error: Error
    let errorMessage: String
    let onRetry: () -> Void

    /// Inicializador personalizado para la vista de error.
    /// - Parameters:
    ///   - error: El error asociado.
    ///   - errorMessage: El mensaje  para mostrar.
    ///   - onRetry: Callback para el metodo retry

    init(error: Error, errorMessage: String, onRetry: @escaping () -> Void) {
        self.error = error
        self.errorMessage = errorMessage
        self.onRetry = onRetry
    }
    
    // MARK: - Body

    var body: some View {
        VStack {
            Image("LogoTwo")
                .logoTwoStyle()
                     
            Text(errorMessage)
                .headlineStyle()

            Text(error.localizedDescription)
                .bodyStyle()
            
            Button(action: {
                onRetry()
            }) {
                HStack {
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                             
                     Text("Recargar")
                         .font(.headline)
                         .foregroundColor(.white)
                }
                         .padding()
                         .background(UIStyles.globalColor)
                         .cornerRadius(10)
                         .padding(.top, 20)
                         .frame(height: 100)
            }
            
            
            Spacer()
            
            Image("Dashphoto")
                .dashPhotoStyle()
        }
            .edgesIgnoringSafeArea(.all)
    }
}

// MARK: - ErrorView_Previews

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        // Vista de error con un ejemplo de error y mensaje personalizado
        ErrorView(
            error: NSError(domain: "com.example", code: 42, userInfo: [NSLocalizedDescriptionKey: "Ejemplo de error"]),
            errorMessage: "Error cargando los pokemon",
            onRetry: {}
        )
    }
}
