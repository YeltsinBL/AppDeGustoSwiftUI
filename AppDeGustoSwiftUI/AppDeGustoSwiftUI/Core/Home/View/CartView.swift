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
    var body: some View {
        ZStack {
            Color("Bg")
                .ignoresSafeArea(edges: .all)
            ScrollView {
                        if cartManager.dishes.count > 0 {
                            ForEach(cartManager.dishes, id:\.id) { dish in
                                CardProductRow(dish: dish).environmentObject(cartManager)
                                Rectangle().frame(width: .infinity, height: 1).padding(.leading).padding(.trailing).foregroundStyle(.gray.opacity(0.2))
                            }
                            HStack {
                                
                                Text("Tu total a pagar es")
                                Spacer()
                                Text("\(cartManager.totalPrice, specifier: "%.2f")")
                            }.padding()
                        }else {
                            Text("Tu carrito esta vacio")
                        }
                        
                    }
                    .frame(width: .infinity)
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
            //        .toolbarBackground(.hidden)
                    .padding(.top)
        }
        
    }
}

#Preview {
    CartView()
        .environmentObject(CartManager())
}
