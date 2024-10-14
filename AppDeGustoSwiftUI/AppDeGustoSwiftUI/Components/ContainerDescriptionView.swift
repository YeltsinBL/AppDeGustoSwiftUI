//
//  ContainerDescriptionView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 9/10/24.
//

import SwiftUI

struct ContainerDescriptionView<Content: View>: View {
    @ViewBuilder let content: Content
    var body: some View {
        HStack {
            content
        }
        .background(Color("Bg"))
        .clipShape(RoundedRectangle(cornerRadius: 40))
    }
}

#Preview {
    ContainerDescriptionView(content: {
        Spacer()
        VStack (alignment: .leading, spacing: 10) {
            Text("Plato")
                .font(.title)
                .fontWeight(.bold)
            Text("Description")
                .font(.system(size: 15))
            Text("S/price")
                .fontWeight(.bold)
                .font(.system(size: CGFloat(18)))
        }.padding()
        Spacer()
    })
}
