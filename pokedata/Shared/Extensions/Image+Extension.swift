//
//  Image+Extension.swift
//  pokedata
//
//  Created by Camiilo on 20/01/24.
//

import Foundation
import SwiftUI

extension Image {
    /// Estilos para la imagen  LogoTwo
    func logoTwoStyle() -> some View {
        self
            .font(UIStyles.logoStyle)
            .foregroundColor(UIStyles.colorError)
            .padding(.bottom, 10)
            .padding(.top, 70)
    }
    
    /// Estilos para la imagen DashPhoto
    func dashPhotoStyle() -> some View {
        self
            .frame(minWidth: 0, maxWidth: CGFloat.infinity)
            .frame(height: 350)
    }
}
