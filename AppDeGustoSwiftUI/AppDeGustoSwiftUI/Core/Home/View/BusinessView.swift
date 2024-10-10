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
    @StateObject var viewModelDish = DishViewModel()
    let business: Business
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
                    
                    DescriptionView(business: business, dish: viewModelDish.dishByBusiness)
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
            .navigationBarBackButtonHidden(true)
//            .navigationTitle(hasScrolled ? business.businessName : "")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        ToolBarItemView(name: hasScrolled ? business.businessName : "", color: .white)
                    }
                }
            }
            .toolbarBackground(.hidden)
            .onAppear {
                viewModelDish.getDishByBusiness(id: business.id)
            }
        }
    }
}

#Preview {
    BusinessView(business: Business(businessId: 1, businessName: "La Buena Mesa", businessAddress: "123 Gourmet Street", businessPhoneNumber: "123456789", businessStatus: 2, businessLogo: "restaurant_logo.png", businessLatitude: -8.069442, businessLongitude: -79.05701, businessCategorization: 3, businessAverageRating: 4.5, businessTotalReviews: 5, businessDistance: "541.14 m "))
}

struct DescriptionView: View {
    let business:Business
    let dish:[Dish]
    var body: some View {
        VStack (alignment: .center) {
            Text(business.businessName)
                .font(.title)
                .fontWeight(.bold)
            HStack (spacing: 4) {
                VStack {
                    Text("Calificación").foregroundStyle(.gray).font(.system(size: 15))
                    CardRating(businessAverageRating: business.businessAverageRating, businessTotalReviews: business.businessTotalReviews)
                }
                Spacer()
                VStack {
                    Text("Categorización").foregroundStyle(.gray).font(.system(size: 15))
                    CardCategorizationDish(nroCategorization: business.businessCategorization)
                }
                Spacer()
                VStack {
                    Text("Distancia").foregroundStyle(.gray).font(.system(size: 15))
                    CardDistanceLocation(businessDistance: business.businessDistance,size: 14)
                }
            }
            .padding(8)
            .overlay(RoundedRectangle(cornerRadius: 25).stroke(.gray.opacity(0.3), lineWidth: 1))
        }
        .padding()
//        .padding(.top)
        .background(Color("Bg"))
        .clipShape(RoundedRectangle(cornerRadius: 40))
        
        Text("Platos Recomendados")
            .font(.custom("IstokWeb-Bold", size: 24))
            .padding(.horizontal)
            .padding(.top)
        ScrollView (.vertical, showsIndicators: false) {
            HStack {
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(dish, id: \.id) { item in
                        NavigationLink(destination: DishView(dish: item)) {
                            CardDishView(dish: item, size: 165)
                        }
                        .foregroundStyle(.black)
                        
                    }
                    .padding(.trailing)
                }
            }
        }
        .padding(.leading)
//        .padding(.trailing)
    }
}
