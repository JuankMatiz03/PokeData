//
//  CardView.swift
//  pokedata
//
//  Created by Camiilo on 21/01/24.
//

import SwiftUI

/// Vista CardView contine la imagen y el titulo del pokemon
struct CardView: View {
    
    // MARK: - ViewModel
    
    let viewModel: CardViewModel

    // MARK: - body
    
    var body: some View {
        VStack {
            Image(viewModel.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 80)
                .padding()

            Text(viewModel.title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.purple)
                .padding(.bottom, 10)
        }
        .frame(width: 180, height: 180)
        .background(UIStyles.globalColor.opacity(0.2))
        .cornerRadius(15)
        .padding(10)
    }
}

// MARK: - CardView_Previews

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CardViewModel(title: "Pokemon List", imageName: "LogoTwo")
        CardView(viewModel: viewModel)
    }
}
