//
//  CardDishView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 30/09/24.
//

import SwiftUI

struct CardDishView: View {
    let name: String
    let description:String
    let image: Image
    let price: String
    let size: CGFloat
    var body: some View {
        VStack (alignment: .leading){
            image
                .resizable()
                .frame(width: size, height: 200 * (size/210))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            Text(name)
                .font(.title3)
//                .fontWeight(.bold)
            VStack(alignment: .leading,spacing: 2) {
                Text(description)
                    .lineSpacing(8)
                    .opacity(0.4)
                    .lineLimit(2)
                Text("S/ \(price)")
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
    CardDishView(name:"Conchitas Parmesanas",description: "Descripcion de todos los platos para visualizarlo cuando se esta en el restaurante y el propio plato",image: Image("plato1"), price: "25.0", size: 180)
}
