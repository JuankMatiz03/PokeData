//
//  LoadingView.swift
//  pokedata
//
//  Created by Camiilo on 20/01/24.
//

import SwiftUI

/// Vista del estado de carga
struct LoadingView: View {
    @State private var rotation: Double = 0.0

    // MARK: - Body
    
    var body: some View {
        VStack {
            
            loadingImage
            loadingText
        }

    }
    
    /// Texto para el estado de carga
    private var loadingText: some View {
        Text("CARGANDO")
            .padding(.top, 40)
            .font(.system(size: 35, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .shadow(color: UIStyles.globalColor, radius: 2, x: 0, y: 2)
    }
    
    ///Imagen para el estado de carga
    private var loadingImage: some View {
        Image("Logo")
            .scaledToFit()
            .shadow(color: UIStyles.globalColor, radius: 20)
            .frame(width: 100, height: 100)
            .rotationEffect(Angle(degrees: rotation))
            .onAppear() {
                 rotate()
             }
    }
    
    /// Animacion de rotacion para la imagen en 360
    private func rotate() {
          withAnimation(Animation.linear(duration: 2.0).repeatForever(autoreverses: false)) {
              self.rotation += 360.0
          }
      }
}

// MARK: - Loading_Previews

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
