//
//  CartButton.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 10/10/24.
//

import SwiftUI

struct CartButton: View {
    var numberOfDishes: Int
    var body: some View {
        ZStack (alignment:.topTrailing){
            Image(systemName: "cart.fill")
                .resizable()
                .tint(Color("Primary"))
                .frame(width:42, height: 42)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            if(numberOfDishes > 0){
                Text("\(numberOfDishes)")
                    .font(.title3).bold()
                    .foregroundStyle(.white)
                    .frame(width: 25, height:  25)
                    .background(.red)
                    .clipShape(Circle())
                    .offset(x:5,y:-5)
            }
        }
    }
}

#Preview {
    CartButton(numberOfDishes: 1)
}
