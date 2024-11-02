//
//  HomeView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 23/09/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModelDish = DishViewModel()
    @StateObject var viewModelBusiness = BusinessViewModel()
    @StateObject var cartManager = CartManager()
    @State private var selectedIndex: Int = 4
//    @State private var categoryDishId:Int = 1
    private let categories = ["Pastas", "Criolla", "Asiatica", "Postres", "Pizzas"]
    // Side Menu Bar View
    @State private var showMenu = false
    var body: some View {
        ZStack {
            Color("Bg")
                .ignoresSafeArea(edges: .all)
            // Contenido principal
            ScrollView {
                VStack (alignment: .leading){
                    // Menu y Usuario
                    AppBarView(showMenu: $showMenu).environmentObject(cartManager)
                    // Texto
                    TagLineView()
                        .padding()
                    //Buscar
                    CardSearchView().environmentObject(cartManager).environmentObject(viewModelBusiness)
                    // Tipos de Restaurantes
                    HStack {
                        LazyVGrid(columns: [GridItem(), GridItem()]) {
                            ForEach(viewModelDish.dishCategory, id: \.id) {
                                dishCategory in
                                CategoryView(isActive: dishCategory.id - 1 == selectedIndex, text: dishCategory.dishCategoryName)
                                    .padding(.vertical,3)
                                    .onTapGesture{
                                        selectedIndex = dishCategory.id - 1
                                        viewModelDish.getPopularDish(id: dishCategory.id)
                                    }
                            }
                        }
                    }.padding()
                    
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
                    
                    Text("Platos Recomendados")
                        .font(.custom("IstokWeb-Bold", size: 24))
                        .foregroundStyle(Color("Primary"))
                        .padding(.horizontal)
                        .padding(.top)
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModelDish.dishPopular, id: \.id){ dishPopular in
                                CardDishView(dish:dishPopular, size: 180)
                            }
                            .padding(.trailing)
                        }
                        .padding(.leading)
                    }
                }
            }
            
            // Diseño del Tab View
//              TabView()
                
            // Diseño del Side Menu View
            SideBarView(isShowing: $showMenu)
        }
        .onAppear{
//              showMenu = false
            viewModelDish.getAllDishCategory()
            Task {
                await viewModelBusiness.getBusinessPopular()  // Se usa try para manejar el posible error
            }
        }
    }
}

#Preview {
    NavigationView {
        HomeView(viewModelDish: .init(), viewModelBusiness: .init())
    }
    
}

struct AppBarView: View {
    @EnvironmentObject var cartManager: CartManager
    @Binding var showMenu: Bool
    var body: some View {
        HStack {
            Button(action: {showMenu.toggle()}) {
                Image("menu")
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            Spacer()
            NavigationLink(destination:
                            CartView(titulo: "Tu carrito").environmentObject(cartManager)
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

struct CardSearchView: View {
    @State private var search: String = ""
    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var viewModelBusiness: BusinessViewModel
    var body: some View {
        NavigationLink(
            destination: {
                withAnimation(.easeInOut) {
                    SearchView().environmentObject(cartManager).environmentObject(viewModelBusiness)
                }
            },
            label: {
                HStack {
                    HStack(spacing: 0) {
                        Image("Search").foregroundStyle(Color("Primary"))
                            .padding(.trailing, 8)
                        Text("Que deseas hoy?")
                            .foregroundStyle(.gray.opacity(0.5))
                            .bold()
                        Spacer()
                    }
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
        })
        
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

