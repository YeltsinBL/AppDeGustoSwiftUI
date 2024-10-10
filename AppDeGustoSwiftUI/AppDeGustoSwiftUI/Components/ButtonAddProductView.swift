//
//  ButtonAddProduct.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 10/10/24.
//

import SwiftUI

struct ButtonAddProduct: View {
    @State var block=false
    @State var valor=0
    @State var espacio:CGFloat = 10
    @State var espaciog:CGFloat = 0
    var body: some View {
        HStack {
            
            if(valor > 0) {
                Button("-") {
                    if(block && valor == 1){
                        valor = 1
                    }else {
                        valor -= 1
                    }
                }.bold()
                Text("\(valor)").padding(.leading,espaciog).padding(.trailing,espaciog)
            }
            Button("+") { valor += 1 }.bold()
        }
        .padding(espaciog)
        .foregroundStyle(.black)
        .padding(.leading, espacio)
        .padding(.trailing, espacio)
        .font(.title)
        .background(.white.opacity(block ? 1 : 0))
        .shadow(color: .black.opacity(0.15), radius: 8, x: 2, y: 6)
        .border(.gray, width: valor == 0 ? 0 : 1)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    ButtonAddProduct()
}
