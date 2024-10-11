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
    @State private var dishes: [Dish] = [
        Dish(dishId: 1, dishName: "Prueba ", dishDescription: "", dishPrice: 12.5, dishPhoto: "plato1"),
        Dish(dishId: 2, dishName: "Prueba2 ", dishDescription: "", dishPrice: 15.5, dishPhoto: "plato1"),
        Dish(dishId: 3, dishName: "Prueba3 ", dishDescription: "", dishPrice: 20.5, dishPhoto: "plato1")
        ]
    @State private var isExpanded = true // Controla si la sección está expandida o colapsada
    @Binding var total: Float
    let textFormatter = TextFormatter()
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
                ForEach($dishes, id: \.id) { $category in
                    HStack {
                        Image("\(category.dishPhoto)")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .background(.yellow)
                            .padding(.horizontal,5)
                            .clipShape(Circle())
                        VStack (alignment: .leading){
                            Text(category.dishName)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("+ \(textFormatter.priceFormatter(Float(category.dishPrice)) )").font(.headline).bold()
                        }
                            Spacer()
                        ButtonAddProduct(valor: $category.quantity, espacio: 5).environmentObject(cartManager)
                    }
                    .cornerRadius(5)
                    .padding( 10)
                    .onAppear {
                        // Actualiza el total en la vista principal
                        total = calculateTotal()
                    }
                    .onChange(of: dishes) {
                        // Cada vez que cambie la lista de platos, actualiza el total
                        total = calculateTotal()
                    }
                    Rectangle()
                        .frame(width: .infinity, height: 1)
                        .padding(.leading).padding(.trailing)
                }
            }
        }
        .padding()
    }
    // Función para calcular el total
    func calculateTotal() -> Float {
        return dishes.reduce(0) { $0 + (Float($1.quantity) * Float($1.dishPrice)) }
    }
}

#Preview {
    @State var number:Float = 0
    AddOnsView(total: $number).environmentObject(CartManager())
}
