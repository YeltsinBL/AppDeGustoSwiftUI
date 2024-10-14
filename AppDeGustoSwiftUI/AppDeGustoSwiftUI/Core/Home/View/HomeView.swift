//
//  HomeView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 23/09/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @StateObject var viewModelDish = DishViewModel()
    @StateObject var viewModelBusiness = BusinessViewModel()
    @StateObject var cartManager = CartManager()
    @State private var selectedIndex: Int = 4
//    @State private var categoryDishId:Int = 1
    private let categories = ["Pastas", "Criolla", "Asiatica", "Postres", "Pizzas"]
    var body: some View {
        NavigationView {
            ZStack {
                Color("Bg")
                    .ignoresSafeArea(edges: .all)
                // Contenido principal
                ScrollView {
                    VStack (alignment: .leading){
                        // Menu y Usuario
                        AppBarView().environmentObject(cartManager)
                        // Texto
                        TagLineView()
                            .padding()
                        //Buscar
                        SearchView()
                        // Tipos de Restaurantes
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModelDish.dishCategory, id: \.id) {
                                    dishCategory in
                                    CategoryView(isActive: dishCategory.id - 1 == selectedIndex, text: dishCategory.dishCategoryName)
                                        .onTapGesture{
                                            selectedIndex = dishCategory.id - 1
                                            viewModelDish.getPopularDish(id: dishCategory.id)
                                        }
                                }
                                
                            }
                        }
                        .padding(.top)
                        .padding(.leading)
                        .padding(.bottom)
                        
                        VStack {
                            Text("Restaurantes ")
                                .font(.custom("IstokWeb-Regular", size: 24))
                                .foregroundStyle(Color("Primary"))
                            + Text("Mas Populares")
                                .font(.custom("IstokWeb-Bold", size: 28)).foregroundStyle(Color("Primary")).bold()
                        }.padding(.horizontal)
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModelBusiness.businessPopular, id: \.id) { businessPopular in
                                    NavigationLink(destination: BusinessView(business:businessPopular).environmentObject(cartManager), label: {
                                        CardBusinessView(business: businessPopular, size: 210)
                                    })
                                    .toolbar(Visibility.hidden)
                                    .foregroundStyle(.black)
                                    
                                }
                                .padding(.trailing)
                            }
                            .padding(.leading)
                        }
                        
//                        Text("Platos Recomendados")
//                            .font(.custom("IstokWeb-Bold", size: 24))
//                            .padding(.horizontal)
//                            .padding(.top)
//                        ScrollView (.horizontal, showsIndicators: false) {
//                            HStack {
//                                ForEach(viewModelDish.dishPopular, id: \.id){ dishPopular in
//                                    CardDishView(dish:dishPopular, size: 180)
//                                }
//                                .padding(.trailing)
//                            }
//                            .padding(.leading)
//                        }
                    }
                }
                
                // Diseño del Tab View
//                TabView()
            }
            .onAppear{
                viewModelDish.getAllDishCategory()
                Task {
                    await viewModelBusiness.getBusinessPopular()  // Se usa try para manejar el posible error
                        
                }
                

//                viewModelDish.getPopularDish(id: selectedIndex+1)
            }
        }
    }
}

#Preview {
    HomeView(viewModelDish: .init(), viewModelBusiness: .init())
}

struct AppBarView: View {
    @EnvironmentObject var cartManager: CartManager
    var body: some View {
        HStack {
            Button(action: {}) {
                Image("menu")
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            Spacer()
            NavigationLink(destination:
                            CartView().environmentObject(cartManager)
            , label: {
                CartButton(numberOfDishes: cartManager.dishes.count)
            })
        }
        .padding(.horizontal)
    }
}

struct TagLineView: View {
    var body: some View {
        Text("Encuentra los \nmejores ")
            .font(.custom("IstokWeb-Regular", size: 28))
            .foregroundStyle(Color("Primary"))
        + Text("Restaurantes!")
            .font(.custom("IstokWeb-Bold", size: 28))
            .foregroundStyle(Color("Primary"))
    }
}

struct SearchView: View {
    @State private var search: String = ""
    var body: some View {
        HStack {
            HStack {
                Image("Search")
                    .padding(.trailing, 8)
                TextField("Buscar...", text: $search)
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal)
    }
}

struct CategoryView: View {
    let isActive: Bool
    let text: String
    var body: some View {
        VStack (alignment: .leading, spacing: 0){
            Text(text)
                .font(.system(size: 18))
                .fontWeight(.medium)
                .foregroundStyle(isActive ? Color("Primary"): Color.black.opacity(0.5))
            if (isActive) {
                Color("Primary")
                    .frame(width: 55, height: 2)
                    .clipShape(Capsule())
            }
        }
        .padding(.trailing)
    }
}

