//
//  ImageLoadView.swift
//  pokedata
//
//  Created by Camiilo on 22/01/24.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

///  Vista  para cargar y mostrar imagenes de pokemon desde una URL.
struct PokemonImageView: View {
    var url: URL?
    
    var body: some View {
        Group {
            if let imageUrl = url {
                WebImage(url: imageUrl)
                    .resizable()
                    .renderingMode(.original)
                    .scaledToFit()
                    .transition(.fade)
                    .animation(.easeOut(duration: 0.5))
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .frame(width: 200, height: 200)
                    .padding([.vertical, .horizontal])
                    .eraseToAnyView()
            } else {
                Text("Imagen no disponible")
            }
        }
    }
}
