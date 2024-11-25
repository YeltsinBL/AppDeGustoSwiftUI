//
//  CardProductRow.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 10/10/24.
//

import SwiftUI

struct CardProductRow: View {
    @EnvironmentObject var cartManager:CartManager
    @State var dish: Dish
    let textFormatter = TextFormatter()
    @Binding var valor:Int?
    @State var business: Business?
    var body: some View {
        HStack(spacing:10) {
            Image("plato1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 75)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            VStack (alignment:.leading){
                    Text(dish.dishName).bold()
                    Text("\(textFormatter.priceFormatter(Float(dish.dishPrice)))")
                HStack {
                    Spacer()
                    ButtonAddProduct(valor: $valor, espacio:10, espaciog: 0, isProductRow: true, icon: valor == 1 ? "trash" : "minus", dish: dish, business: business).environmentObject(cartManager)
                }
            }
        }
        .padding(.horizontal)
        .frame(alignment: .leading)
    }
}

#Preview {
    @State var dish:Dish = Dish(dishId: 1, dishName: "Conchitas Parmesanas", dishDescription: "Conchitas de abanico, queso crema, banado con gotas de limon, 6pz.", dishPrice: 25.0, dishPhoto: "https://res.cloudinary.com/dkd0jybv9/image/upload/c_crop,g_auto,h_550,w_800/test/Tallar%C3%ADn%20con%20pollo%2061.jpg")
    @State var number:Int?=1
    CardProductRow(dish: dish, valor: $number, business: Business(businessId: 1, businessName: "La Buena Mesa", businessAddress: "123 Gourmet Street", businessPhoneNumber: "123456789", businessStatus: 2, businessLogo: "https://res.cloudinary.com/dkd0jybv9/image/upload/v1728453775/test/El%20sombrero.png", businessLatitude: -8.069442, businessLongitude: -79.05701, businessCategorization: 3, businessAverageRating: 4.5, businessTotalReviews: 5, businessDistance: "541.14 m ", dishes: nil)).environmentObject(CartManager())
}
