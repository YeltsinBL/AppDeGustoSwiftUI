//
//  DishView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 9/10/24.
//

import SwiftUI

struct DishView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var cartManager:CartManager
    @State private var hasScrolled = false  // Controla si se ha hecho scroll o no
    @State var dish: Dish
    let textFormatter = TextFormatter()
    @State var valor:Int? = 1
    @State var valorComplementary:Float = 0
    var body: some View {
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
                if(dish.dishPhoto.hasPrefix("https")){
                    AsyncImage(url: URL(string: "\(textFormatter.urlFormatter(dish.dishPhoto,2))"),
                               content: { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .offset(y:-10)
                                },
                               placeholder: { ProgressView() }
                    )
                    .frame(height: 345)
                    .aspectRatio(contentMode: .fit)
                    .offset(y:-10)
                } else {
                    Image(dish.dishPhoto)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .offset(y:-10)
                }
                VStack {
                    ContainerDescriptionView(content: {
                        Spacer()
                        VStack (alignment: .leading, spacing: 10) {
                            Text(dish.dishName)
                                .font(.title)
                                .fontWeight(.bold)
                            Text(dish.dishDescription)
                                .font(.system(size: 15))
                            Text("S/\(dish.dishPrice, specifier: "%.2f")")
                                .fontWeight(.bold)
                                .font(.system(size: CGFloat(18)))
                        }.padding().foregroundStyle(.black)
                        Spacer()
                    })
                    AddOnsView(total: $valorComplementary)
                }.offset(y:-70)
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
            ButtonAddToCarView(dish: $dish, total: Float(dish.dishPrice * Double(valor!)) +
                               valorComplementary, valor: $valor)
                .offset(y: -24)
                .background(
                    LinearGradient(colors: [.gray.opacity(0), .gray], startPoint: .top, endPoint: .bottom)
                        .frame(height: 50)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .allowsHitTesting(false)
                )
                .ignoresSafeArea()
                .environmentObject(cartManager)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    ToolBarItemView(name: "", color: .white)
                }
            }
        }
        .toolbarBackground(.hidden)
        .onAppear {
        }
    }
}

#Preview {
    DishView(dish: Dish(dishId: 1, dishName: "Conchitas Parmesanas", dishDescription: "Conchitas de abanico, queso crema, banado con gotas de limon, 6pz.", dishPrice: 25.0, dishPhoto: "https://res.cloudinary.com/dkd0jybv9/image/upload/c_crop,g_auto,h_550,w_800/test/Tallar%C3%ADn%20con%20pollo%2061.jpg")).environmentObject(CartManager())
}
