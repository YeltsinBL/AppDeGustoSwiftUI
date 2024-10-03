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
                        AppBarView()
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
//                                            categoryDishId = dishCategory.id
//                                            print(categoryDishId)
                                            viewModelDish.getPopularDish(id: dishCategory.id)
                                        }
                                }
                            }
                        }
                        .padding(.top)
                        .padding(.leading)
                        .padding(.bottom)
                        
                        Text("Restaurantes")
                            .font(.custom("IstokWeb-Bold", size: 24))
                            .padding(.horizontal)
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0 ..< 5) { item in
                                    NavigationLink(destination: BusinessView(), label: {
                                        CardBusinessView(image: Image("plato\(item+1)"), size: 210)
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
//                TabView()
            }
            .onAppear{
                viewModelDish.getAllDishCategory()
                viewModelDish.getPopularDish(id: selectedIndex+1)
            }
        }
    }
}

#Preview {
    HomeView(viewModelDish: .init())
}

struct AppBarView: View {
    var body: some View {
        HStack {
            Button(action: {}) {
                Image("menu")
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            Spacer()
            Button(action: {}) {
                Image(systemName: "cart.fill")
                    .resizable()
                    .tint(Color("Primary"))
                    .frame(width:42, height: 42)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
            }
        }
        .padding(.horizontal)
    }
}

struct TagLineView: View {
    var body: some View {
        Text("Encuentra el \nmejor ")
            .font(.custom("IstokWeb-Regular", size: 28))
            .foregroundStyle(Color("Primary"))
        + Text("Restaurante!")
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

struct CardBusinessView: View {
    let image: Image
    let size: CGFloat
    var body: some View {
        VStack {
            image
                .resizable()
                .frame(width: size, height: 200 * (size/210))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            Text("Al Dente")
                .font(.title3)
                .fontWeight(.bold)
            HStack(spacing: 2) {
                ForEach(0..<5) { item in
                    Image("star")
                }
                Spacer()
                Text("$25")
                    .font(.title3)
                    .fontWeight(.bold)
            }
        }
        .frame(width: size)
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
