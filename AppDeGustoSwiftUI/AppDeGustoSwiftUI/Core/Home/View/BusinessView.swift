//
//  BusinessView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 30/09/24.
//

import SwiftUI
import Foundation

struct BusinessView: View {
    @Environment(\.dismiss) var dismiss
    @State private var hasScrolled = false  // Controla si se ha hecho scroll o no
    var body: some View {
        VStack {
            ZStack {
                Color("Bg")
                    .ignoresSafeArea(.all)
                ScrollView (showsIndicators: false){
                // Usamos GeometryReader para detectar el desplazamiento
                GeometryReader { geometry in
                    let value = geometry.frame(in: .global).minY
                    Color.clear
                        .onChange(of: value) {
                            if value < -200 {
                                // Si el desplazamiento es mayor que 0 (ha hecho scroll)
                                hasScrolled = true
                            } else {
                                // Si está en la parte superior
                                hasScrolled = false
                            }
                        }
                }
                .frame(height: 0)  // Necesitamos el GeometryReader pero no queremos que ocupe espacio
                    Image("plato1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .offset(y:-10)
                    
                    DescriptionView()
                        .offset(y: -50)
                }
                .ignoresSafeArea(.all)
                // Imagen difuminada en la barra de navegación cuando se hace scroll
                if hasScrolled {
                    VStack {
                        Image("plato1")  // Reemplaza con el nombre de tu imagen
                            .resizable()
                            .scaledToFill()
                            .frame(alignment: .top)
                            .frame(height: 95)  // Altura que quieres darle a la imagen
                            .blur(radius: 10)   // Aplica el desenfoque
                            .clipped()
                            .frame(maxWidth: .infinity)
                            .transition(.opacity)  // Animación de aparición/desaparición
                        .animation(.easeInOut, value: hasScrolled)// Animación suave al mostrar la imagen
                        
                        Spacer()
                    }.ignoresSafeArea()
                        
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle(hasScrolled ? "Restaurante" : "")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.backward")
                            .tint(Color("Primary"))
                            .padding(.all, 8)
                            .background(.white)
                            .clipShape(Circle())
                    }
                }
            }
            .toolbarBackground(.hidden)
        }
    }
}

#Preview {
    BusinessView()
}

struct DescriptionView: View {
    var body: some View {
        VStack (alignment: .center) {
            Text("Restaurante 1")
                .font(.title)
                .fontWeight(.bold)
            HStack (spacing: 4) {
                ForEach(0 ..< 5) { item in
                    Image("star")
                }
                Text("(4.9)")
                    .opacity(0.5)
                    .padding(.leading, 8)
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .padding(.top)
        .background(Color("Bg"))
        .clipShape(RoundedRectangle(cornerRadius: 40))
        
        Text("Platos Recomendados")
            .font(.custom("IstokWeb-Bold", size: 24))
            .padding(.horizontal)
            .padding(.top)
        ScrollView (.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0 ..< 5) { item in
                    CardDishView(name: "Plato \(item + 1)", description: "Descripcion de todos los platos para visualizarlo cuando se esta en el restaurante y el propio plato", image: Image("plato\(item+1)"), price: "30", size: 170)
                }
                .padding(.trailing)
            }
        }
        .padding(.leading)
        .padding(.trailing)
    }
}
