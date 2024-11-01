//
//  CartView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 10/10/24.
//

import SwiftUI

struct CartView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var cartManager:CartManager
    @State var titulo:String
    var body: some View {
        ZStack {
            Color("Bg")
                .ignoresSafeArea(edges: .all)
            ScrollView {
                        if cartManager.dishes.count > 0 {
                            ForEach($cartManager.dishes, id:\.id) { $dish in
                                CardProductRow(dish: dish, valor: $dish.quantity).environmentObject(cartManager)
                                Divider()
                                    .background(.gray.opacity(0.2))
                            }
                            Button(action: {
                                cartManager.removeAllDish()
                            }, label: {
                                Text("Vaciar carrito")
                                    .foregroundStyle(.red)
                                    .font(.footnote)
                            }).padding(.vertical)
                            HStack {
                                
                                Text("Tu total a pagar es")
                                Spacer()
                                Text("\(cartManager.totalPrice, specifier: "%.2f")")
                            }.padding()
                        }else {
                            VStack(alignment: .center) {
                                Image(systemName: "cart")
                                    .padding(.all, 8)
                                    .background(.gray.opacity(0.2))
                                    .clipShape(Circle())
                                Text("Aun no has agregado platos en tu carrito").lineLimit(2).multilineTextAlignment(.center)
                            }.padding(.top, 30).frame(width: 300)
                            
                        }
                        
                    }
                    .foregroundStyle(.black).bold()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Tu carrito")
                    .toolbar{
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                dismiss()
                            }) {
                                ImageButtonBackView()
                            }
                        }
                    }
            //        .toolbarBackground(.hidden)
                    .padding(.top)
        }
    }
}

#Preview {
//    CartView(titulo: "Tu carrito")
//        .environmentObject(CartManager())
    NavigationView {
        HomeView(viewModelDish: .init(), viewModelBusiness: .init())
    }
//    CartToolBar()
}
