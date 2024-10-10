//
//  AddOnsView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 9/10/24.
//

import SwiftUI

struct AddOnsView: View {
    @EnvironmentObject var cartManager:CartManager
    @State private var selectedCategory = 0
    let categories = ["Pastas", "Criolla", "Asiatica", "Postres", "Pizzas"]
    @State private var isExpanded = true // Controla si la sección está expandida o colapsada
     
    var body: some View {
        VStack {
            // Título que se puede tocar para expandir o colapsar la lista
            Button(action: {
                withAnimation {
                    isExpanded.toggle() // Cambia entre expandido y colapsado
                }
            }) {
                HStack {
                    VStack(alignment:.leading) {
                        Text("Complementos")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("(Opcionales)")
                    }
                    .foregroundStyle(.black)
                    Spacer()
                    // Ícono de flecha que cambia según si la lista está expandida o no
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .tint(Color("Primary"))
                        .padding(.all, 8)
                        .background(.gray.opacity(0.2))
                        .clipShape(Circle())
                    }
                    .padding()
                    .cornerRadius(10)
                }
            Rectangle().frame(width: .infinity, height:1)
                .padding(.leading).padding(.trailing)
                    
            // La lista de elementos que se muestra solo si está expandido
            if isExpanded {
                ForEach(categories, id: \.self) { category in
                    HStack {
                        Text(category)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                        ButtonAddProduct().environmentObject(cartManager)
                        }
                        .cornerRadius(5)
                        .padding([.leading, .trailing], 10)
                    Rectangle().frame(width: .infinity, height: 1).padding(.leading).padding(.trailing)
                }
            }
        }
        .padding()
    }
}

#Preview {
    AddOnsView().environmentObject(CartManager())
}
