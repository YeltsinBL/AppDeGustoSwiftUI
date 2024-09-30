//
//  HomeView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 23/09/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var selectedIndex: Int = 0
    private let categories = ["Pastas", "Criolla", "Asiatica", "Postres", "Pizzas"]
    var body: some View {
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
                            ForEach(categories.indices, id: \.self) { item in
                                CategoryView(isActive: item == selectedIndex, text: categories[item])
                                    .onTapGesture{
                                        selectedIndex = item
                                    }
                            }
                        }
                    }
                    .padding()
                    
                    Text("Restaurantes")
                        .font(.custom("IstokWeb-Bold", size: 24))
                        .padding(.horizontal)
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0 ..< 5) { item in
                                BusinessView(image: Image("plato\(item+1)"), size: 210)
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
                            ForEach(0 ..< 5) { item in
                                BusinessView(image: Image("plato\(item+1)"), size: 180)
                            }
                            .padding(.trailing)
                        }
                        .padding(.leading)
                    }
                }
            }
            
            // Diseño del Tab View
            HStack {
                BottomNavBarItem(image: Image(systemName: "house.fill")) {
                    
                }
                BottomNavBarItem(image: Image(systemName: "map")) {
                    
                }
                BottomNavBarItem(image: Image(systemName: "heart")) {
                    
                }
                BottomNavBarItem(image: Image(systemName: "person")) {
                    
                }
            }
            .padding()
            .background(.white)
            .clipShape(Capsule())
            .padding(.horizontal)
            .shadow(color: .black.opacity(0.15), radius: 8, x: 2, y: 6)
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}

#Preview {
    HomeView()
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

struct BusinessView: View {
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

struct BottomNavBarItem: View {
    let image: Image
    let action: () -> Void
    var body: some View {
        Button(action: {}, label: {
            image
                .scaledToFill()
                .tint(Color("Primary"))
                .frame(maxWidth: .infinity)
        })
    }
}
