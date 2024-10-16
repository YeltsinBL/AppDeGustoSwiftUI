//
//  ButtonAddToCarView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 10/10/24.
//

import SwiftUI

struct ButtonAddToCarView: View {
    @EnvironmentObject var cartManager:CartManager
    let text = TextFormatter()
    @Binding var dish:Dish
    let total: Float
    @Binding var valor:Int?
    var body: some View {
        VStack {
            Spacer()
            HStack {
                ButtonAddProduct(block: true,valor: $valor, espacio:10, espaciog: 5).environmentObject(cartManager)
//                Spacer()
                Button("Agregar \(text.priceFormatter(total))") {
                    dish.quantity = valor
                    cartManager.add(dish)
                }.frame(width:160).padding().bold().background(Color("Primary")).foregroundStyle(.white).clipShape(RoundedRectangle(cornerRadius: 20))
                
            }.padding(.horizontal)
                .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .bottom)
            .mask(RoundedRectangle(cornerRadius: 26, style: .continuous))
            .shadow(color: .black.opacity(0.15), radius: 8, x: 2, y: 6)
            .overlay(
                RoundedRectangle(cornerRadius: 26, style: .continuous)
                    .stroke(.linearGradient(colors: [.white.opacity(0.5),.white.opacity(0)], startPoint: .topLeading, endPoint: .bottomTrailing))
            )
        }
    }
}

#Preview {
    @State var dish: Dish = Dish(dishId: 1, dishName: "Conchitas Parmesanas", dishDescription: "Conchitas de abanico, queso crema, banado con gotas de limon, 6pz.", dishPrice: 25.0, dishPhoto: "https://res.cloudinary.com/dkd0jybv9/image/upload/c_crop,g_auto,h_550,w_800/test/Tallar%C3%ADn%20con%20pollo%2061.jpg")
    @State var number: Int? = 1
    ButtonAddToCarView(dish: $dish, total: 80.2, valor: $number).environmentObject(CartManager())
}
