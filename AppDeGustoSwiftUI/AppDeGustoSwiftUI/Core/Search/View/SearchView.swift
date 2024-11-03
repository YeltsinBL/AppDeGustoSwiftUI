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
                            ForEach(viewModelBusiness.businessPopular, id: \.id) { businessPopular in
                                SearchContentBusinessView(businessPopular: businessPopular).environmentObject(cartManager)
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
    @EnvironmentObject var cartManager:CartManager
    let businessPopular: Business
    var body: some View {
        VStack {
            HStack {
                CardImageView(nameImage: businessPopular.businessLogo, formatterShape: Circle(), valueWidth: 50)
                VStack(alignment: .leading) {
                    Text(businessPopular.businessName).bold()
                    HStack(spacing:8) {
                        CardAverageRatingView(businessAverageRating: businessPopular.businessAverageRating, size: 12)
                        ImageCircleSeparatorView(sizeWidth: 5)
                        CardCategorizationDish(sizeHeight: 12, nroCategorization: businessPopular.businessCategorization)
                        ImageCircleSeparatorView(sizeWidth: 5)
                        CardDistanceLocation(businessDistance: businessPopular.businessDistance,size: 12)
//                        ImageCircleSeparatorView(sizeWidth: 5)
//                        Text("Aforo").font(.footnote)
                    }.offset(y:-5)
                }
                Spacer()
                NavigationLink(destination: {
                    BusinessView(business:businessPopular).environmentObject(cartManager)
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
//    NavigationView {
//        HomeView(viewModelDish: .init(), viewModelBusiness: .init())
//    }
    SearchContentBusinessView(businessPopular: Business(businessId: 1, businessName: "La Buena Mesa", businessAddress: "123 Gourmet Street", businessPhoneNumber: "123456789", businessStatus: 2, businessLogo: "https://res.cloudinary.com/dkd0jybv9/image/upload/v1728453775/test/El%20sombrero.png", businessLatitude: -8.069442, businessLongitude: -79.05701, businessCategorization: 3, businessAverageRating: 4.5, businessTotalReviews: 5, businessDistance: "541.14 m ")).environmentObject(CartManager())
}
