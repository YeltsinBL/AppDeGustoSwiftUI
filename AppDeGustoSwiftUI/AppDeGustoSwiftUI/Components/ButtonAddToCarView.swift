//
//  ButtonAddToCarView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 10/10/24.
//

import SwiftUI

struct ButtonAddToCarView: View {
    let text = TextFormatter()
    let total: Float
    @State var valor=1
    var body: some View {
        VStack {
            Spacer()
            HStack {
                ButtonAddProduct(block: true,valor: 1, espacio:20, espaciog: 10)
                Spacer()
                Button("Agregar \(text.priceFormatter(total))") {
                    
                }.padding().bold().background(Color("Primary")).foregroundStyle(.white).clipShape(RoundedRectangle(cornerRadius: 20))
                
            }.padding(.leading).padding(.trailing).padding(.horizontal)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .mask(RoundedRectangle(cornerRadius: 26, style: .continuous))
            .shadow(color: .black.opacity(0.15), radius: 8, x: 2, y: 6)
            .overlay(
                RoundedRectangle(cornerRadius: 26, style: .continuous)
                    .stroke(.linearGradient(colors: [.white.opacity(0.5),.white.opacity(0)], startPoint: .topLeading, endPoint: .bottomTrailing))
            )
            .offset(y:10)
        }
    }
}

#Preview {
    ButtonAddToCarView(total: 80.2)
}
