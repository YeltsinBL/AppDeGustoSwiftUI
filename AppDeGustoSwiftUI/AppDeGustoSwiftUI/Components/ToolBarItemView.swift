//
//  ToolBarItemView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 9/10/24.
//

import SwiftUI

struct ToolBarItemView: View {
    let name:String
    let color: Color
    var body: some View {
        HStack {
            Image(systemName: "chevron.backward")
                        .tint(Color("Primary"))
                        .padding(.all, 8)
                        .background(.white)
                        .clipShape(Circle())
                    Text(name)
//                        .font(.title2)
                        .font(.custom("IstokWeb-Bold", size: 22))
                        .fontWeight(.bold)
                        .foregroundStyle(color)
        }
        
    }
}

#Preview {
    ToolBarItemView(name: "Restaurante 1", color: .black)
}
