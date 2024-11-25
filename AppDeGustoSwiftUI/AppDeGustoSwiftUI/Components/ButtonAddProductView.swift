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
    @Binding var valor:Int?
    @State var espacio:CGFloat = 10
    @State var espaciog:CGFloat = 0
    @State var isProductRow = false
    @State var icon:String = "minus"
    var dish:Dish?
    @State var business: Business?
    var body: some View {
        HStack {
            
            if(valor! > 0) {
                Button("", systemImage: icon) {
                    if(block && valor == 1){
                        valor = 1
                    }else {
                        valor! -= 1
                        if(isProductRow && valor == 1){
                            icon = "trash"
                        }
                    }
                    if(isProductRow) {
                        cartManager.remove(dish!)
                    }
                }
                Text("\(valor!)").padding(.leading,espaciog).padding(.trailing,espaciog)
            }
            Button("", systemImage: "plus") {
                valor! += 1
                if(valor! > 1){
                    icon = "minus"
                }
                if isProductRow {
                    cartManager.add(dish!,business, 0)
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
    @State var number : Int? = 1
    ButtonAddProduct(
        valor: $number, business: Business(businessId: 1, businessName: "La Buena Mesa", businessAddress: "123 Gourmet Street", businessPhoneNumber: "123456789", businessStatus: 2, businessLogo: "https://res.cloudinary.com/dkd0jybv9/image/upload/v1728453775/test/El%20sombrero.png", businessLatitude: -8.069442, businessLongitude: -79.05701, businessCategorization: 3, businessAverageRating: 4.5, businessTotalReviews: 5, businessDistance: "541.14 m ", dishes: nil)).environmentObject(CartManager())
}
