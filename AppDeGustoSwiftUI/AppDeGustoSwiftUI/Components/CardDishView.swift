//
//  CardDishView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 30/09/24.
//

import SwiftUI

struct CardDishView: View {
    let dish:Dish
    let size: CGFloat
    var body: some View {
        VStack (alignment: .leading){
            
            VStack{
                if(dish.dishPhoto.hasPrefix("https")){
                    AsyncImage(url: URL(string: "\(dish.dishPhoto)"))
                } else {
                    Image("plato1")
                        .resizable()
                }
            }
            .frame(width: size, height: 200 * (size/210))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            Text(dish.dishName)
                .font(.title3)
//                .fontWeight(.bold)
            VStack(alignment: .leading,spacing: 2) {
                Text(dish.dishDescription)
                    .lineSpacing(8)
                    .opacity(0.4)
                    .lineLimit(2)
                Text("S/ \(dish.dishPrice, specifier: "%.2f")")
                    .font(.subheadline)
                    .fontWeight(.bold)
//                    .padding(.leading)
            }
//            .frame(maxWidth: .infinity)
        }
        .frame(width: size)
//        .padding()
//        .background(.white)
//        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    CardDishView(dish: Dish(dishId: 1, dishName: "Conchitas Parmesanas", dishDescription: "Descripcion de todos los platos para visualizarlo cuando se esta en el restaurante y el propio plato", dishPrice: 20, dishPhoto: "https://res.cloudinary.com/dkd0jybv9/image/upload/c_auto,g_auto,h_172,w_180/plato2.png"), size: 180)
}
