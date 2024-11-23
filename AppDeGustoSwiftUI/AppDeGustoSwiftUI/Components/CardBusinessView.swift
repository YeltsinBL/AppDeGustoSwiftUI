//
//  CardBusinessView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 4/10/24.
//

import SwiftUI

struct CardBusinessView: View {
    let business: Business
//    let image: Image
    let size: CGFloat
    let textFormatter = TextFormatter()
    var body: some View {
        VStack {
            if(business.businessLogo.hasPrefix("https")){
                AsyncImage(url: URL(string: "\(textFormatter.urlFormatter(business.businessLogo,2))"),
                           content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .offset(y:-10)
                            },
                           placeholder: { ProgressView() }
                )
                .frame(width: size, height: 200 * (size/210))
                .aspectRatio(contentMode: .fit)
                .offset(y:-10)
            } else {
                Image("plato1")
                    .resizable()
                    .frame(width: size, height: 200 * (size/210))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            Text(business.businessName)
                .font(.title3)
                .fontWeight(.bold)
            HStack(spacing: 2) {
                CardRating(businessAverageRating: business.businessAverageRating, businessTotalReviews: business.businessTotalReviews)
                Spacer()
                CardDistanceLocation(businessDistance: business.businessDistance, size: 15)
            }
        }
        .frame(width: size)
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}


#Preview {
    CardBusinessView(business: Business(businessId: 1, businessName: "La Buena Mesa", businessAddress: "123 Gourmet Street", businessPhoneNumber: "123456789", businessStatus: 2, businessLogo: "https://res.cloudinary.com/dkd0jybv9/image/upload/v1728453775/test/El%20sombrero.png", businessLatitude: -8.069442, businessLongitude: -79.05701, businessCategorization: 3, businessAverageRating: 4.5, businessTotalReviews: 5, businessDistance: "541.14 m ", dishes: nil), size: 210)
}
