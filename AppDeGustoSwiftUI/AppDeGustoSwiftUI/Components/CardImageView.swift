//
//  CardImageView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 3/11/24.
//

import SwiftUI

struct CardImageView<S: Shape>: View {
    let nameImage: String
    let formatterShape: S
    let valueWidth:CGFloat
    let textFormatter = TextFormatter()
    var body: some View {
        if(nameImage.hasPrefix("https")){
            AsyncImage(
                url: URL(string: "\(textFormatter.urlFormatter(nameImage,2))"),
                transaction: Transaction(animation: .easeInOut),
                content: { phase in
                    switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .transition(.scale(scale: 0.1, anchor: .center))
                        case .failure:
                            Image(systemName: "wifi.slash")
                        @unknown default:
                            EmptyView()
                    }
            })
            .frame(width: valueWidth, height: 200 * (valueWidth/210))
            .aspectRatio(contentMode: .fit)
            .clipShape(formatterShape)
        } else {
            Image("plato1")
                .resizable()
                .transition(.scale(scale: 0.1, anchor: .center))
                .frame(width: valueWidth, height: 200 * (valueWidth/210))
                .clipShape(formatterShape)
        }
    }
}

#Preview {
    CardImageView(nameImage: "https://res.cloudinary.com/dkd0jybv9/image/upload/v1728453775/test/El%20sombrero.png", formatterShape: Circle(), valueWidth: 50)
}
