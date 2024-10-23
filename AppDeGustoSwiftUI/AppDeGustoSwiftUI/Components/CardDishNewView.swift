//
//  CardDishNewView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 22/10/24.
//

import SwiftUI

struct CardDishNewView: View {
    var dish:Dish
    let textFormatter = TextFormatter()
    @State var cant: Int? = 0
    var body: some View {
        HStack{
            VStack{
                if(dish.dishPhoto.hasPrefix("https")){
                    AsyncImage(url: URL(string: "\(textFormatter.urlFormatter(dish.dishPhoto,1))"))
                } else {
                    Image("plato1")
                        .resizable()
                }
            }
            .aspectRatio(contentMode: .fill)
            .frame(width: 130, height:130)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            Spacer(minLength: 10)
            VStack(alignment: .leading, spacing: 10) {
                Text(dish.dishName)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(dish.dishDescription)
                    .font(.caption)
                    .lineLimit(3)
                HStack {
                    Text(textFormatter.priceFormatter(Float(dish.dishPrice)))
                        .fontWeight(.bold)
                    ButtonAddProduct(valor: $cant, espacio:10, espaciog: 0)
                }
                
            }
            .frame(height: 130)
//            .background(.red)
//            Spacer()
        }.padding(.horizontal)
    }
}

#Preview {
    CardDishNewView(dish: Dish(dishId: 1, dishName: "Limonada", dishDescription: "Limonada casera refrescante", dishPrice: 20, dishPhoto: "https://res.cloudinary.com/dkd0jybv9/image/upload/vs/test/plato2.png"))
}
