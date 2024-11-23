//
//  CardNoDishView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 22/11/24.
//

import SwiftUI

struct CardNoDishView: View {
    var body: some View {
        VStack(spacing: 2) {
            Image(systemName: "cart.badge.minus").padding(.horizontal)
                .frame(width:42, height: 42)
            Text("Aun no se han registrado platos para este restaurante")
                .lineLimit(5)
                .multilineTextAlignment(.center)
                .lineSpacing(8)
        }.padding().foregroundStyle(.black).bold()
    }
}

#Preview {
    CardNoDishView()
}
