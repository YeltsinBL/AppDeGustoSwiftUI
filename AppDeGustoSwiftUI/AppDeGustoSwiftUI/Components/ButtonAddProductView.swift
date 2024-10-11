//
//  ButtonAddProduct.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 10/10/24.
//

import SwiftUI

struct ButtonAddProduct: View {
    @EnvironmentObject var cartManager:CartManager
    @State var block=false
    @Binding var valor:Int
    @State var espacio:CGFloat = 10
    @State var espaciog:CGFloat = 0
    @State var isProductRow = false
    @State var icon:String = "minus"
    var dish:Dish?
    var body: some View {
        HStack {
            
            if(valor > 0) {
                Button("", systemImage: icon) {
                    if(block && valor == 1){
                        valor = 1
                        if(isProductRow) {
                            cartManager.remove(dish!)
                        }
                    }else {
                        valor -= 1
                        if(isProductRow && valor == 1){
                            icon = "trash"
                        }
                    }
                }
                Text("\(valor)").padding(.leading,espaciog).padding(.trailing,espaciog)
            }
            Button("", systemImage: "plus") {
                valor += 1
                if(valor > 1){
                    icon = "minus"
                }
            }
        }.bold()
        .frame(width: 125, height: 40)
        .padding(espaciog)
        .foregroundStyle(.black)
        .padding(.leading, espacio)
        .padding(.trailing, espacio)
//        .font(.title)
        .background(.white.opacity(block ? 1 : 0))
        .shadow(color: .black.opacity(0.15), radius: 8, x: 2, y: 6)
        .border(.gray.opacity(0.2), width: valor == 0 ? 0 : 1)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    @State var number : Int = 0
    ButtonAddProduct(
        valor: $number).environmentObject(CartManager())
}
