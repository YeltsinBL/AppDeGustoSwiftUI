//
//  SearchView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 1/11/24.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var viewModelBusiness: BusinessViewModel
    @StateObject var cartManager = CartManager()
    @State var search: String = ""
    let textFormatter = TextFormatter()

    var body: some View {
        ZStack {
            Color("Bg")
                .ignoresSafeArea(edges: .all)
            VStack {
                ToolbarSearchView(search: $search)
                    .environmentObject(cartManager)
                    .padding(.horizontal)
                ScrollView {
                    if (search.count > 2) {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(viewModelBusiness.businessPopular, id: \.id) { businessPopular in
                                    NavigationLink(
                                        destination: BusinessView(business:businessPopular).environmentObject(cartManager),
                                        label: {
                                            SearchContentIconBusinessView(businessPopular: businessPopular)
                                        })
                                    .toolbar(Visibility.hidden)
                                    .foregroundStyle(.black)
                                }
                                .padding(.trailing)
                            }
                        }.padding(.leading)
                        Divider().padding(.horizontal)
                        VStack {
                            ForEach(0..<3) { _ in
                                SearchContentBusinessView()
                            }
                        }
                    }else {
                        Text("Busca por nombre, descripción o palabras clave")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.center)
                            .bold()
                    }
                }
                .foregroundStyle(.black)
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
                .padding(.top)
            }
        }
    }
}

struct ToolbarSearchView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var cartManager: CartManager
    @Binding var search: String
    var body: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                ImageButtonBackView()
            }
            Spacer()
            HStack {
                HStack {
                    Image("Search")
                    TextField("Buscar...", text: $search)
                }
            }
            .padding(8)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
            Spacer()
            NavigationLink(destination:
                            CartView(titulo: "Tu carrito").environmentObject(cartManager)
            , label: {
                CartButton(numberOfDishes: cartManager.dishes.count)
            })
        }
    }
}

struct SearchContentIconBusinessView: View {
    let businessPopular: Business
    let textFormatter = TextFormatter()
    var body: some View {
        VStack {
            CardImageView(nameImage: businessPopular.businessLogo, formatterShape: Circle(), valueWidth: 50)
            Text(businessPopular.businessName)
                .font(.footnote)
                .frame(width: 70)
                .lineLimit(1)
        }
    }
}

struct SearchContentBusinessView:View {
    var body: some View {
        VStack {
            HStack {
                CardImageView(nameImage: "plato1", formatterShape: Circle(), valueWidth: 50)
                VStack(alignment: .leading) {
                    Text("La Granja 21").bold()
                    HStack {
                        Text("Valoración").font(.footnote)
                        Text("Distancia").font(.footnote)
                    }
                }
                Spacer()
                NavigationLink(destination: {
                    
                }) {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(Color("Primary"))
                        .padding(.all, 8)
//                        .background(.white)
//                        .clipShape(Circle())
                }
            }.padding(.bottom)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<3) { _ in
                        NavigationLink(destination: {}) {
                            VStack(alignment:.leading) {
                                CardImageView(nameImage: "plato1", formatterShape: RoundedRectangle(cornerRadius: 20), valueWidth: 118)
                                Text("Nombre").font(.subheadline)
                                Text("S/ \(20.5, specifier: "%.2f")")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                            }
                        }
                    }
                }
            }
            Divider().padding(.vertical)
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
//    NavigationView {
//        SearchView().environmentObject(BusinessViewModel())
//    }
    NavigationView {
        HomeView(viewModelDish: .init(), viewModelBusiness: .init())
    }
//    SearchContentBusinessView()
}
