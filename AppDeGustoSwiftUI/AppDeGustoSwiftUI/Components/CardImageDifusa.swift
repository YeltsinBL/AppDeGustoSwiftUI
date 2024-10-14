//
//  CardImageDifusa.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 14/10/24.
//

import SwiftUI

struct CardImageDifusa: View {
    let image: String
    let hasScrolled: Bool
    let textFormatter = TextFormatter()
    var body: some View {
        VStack {
            HStack {
                if(image.hasPrefix("https")){
                    AsyncImage(url: URL(string: "\(textFormatter.urlFormatter(image,2))"),
                               content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .offset(y:-10)
                    },
                               placeholder: { ProgressView() }
                    )
                    .scaledToFill()
                    .frame(alignment: .top)
                    .frame(height: 95)  // Altura que quieres darle a la imagen
                    .background(.black)
                    .opacity(1)
                    .blur(radius: 50, opaque: true)   // Aplica el desenfoque
                    .clipped()
                    .frame(maxWidth: .infinity)
                    .transition(.opacity)  // Animación de aparición/desaparición
                    .animation(.easeInOut, value: hasScrolled)// Animación suave al mostrar la imagen
                } else {
                    Image("plato1")  // Reemplaza con el nombre de tu imagen
                        .resizable()
                    
                }
            }
            .scaledToFill()
            .frame(alignment: .top)
            .frame(height: 95)  // Altura que quieres darle a la imagen
            .background(.black)
            .opacity(1)
            .blur(radius: 50, opaque: true)   // Aplica el desenfoque
            .clipped()
            .frame(maxWidth: .infinity)
            .transition(.opacity)  // Animación de aparición/desaparición
            .animation(.easeInOut, value: hasScrolled)// Animación suave al mostrar la imagen
            
            Spacer()
        }.ignoresSafeArea()
            
    }
}

#Preview {
    CardImageDifusa(image: "https://res.cloudinary.com/dkd0jybv9/image/upload/v1728453775/test/El%20sombrero.png", hasScrolled: false)
}
