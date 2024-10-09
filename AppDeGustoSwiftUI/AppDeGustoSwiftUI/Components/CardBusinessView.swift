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
    var body: some View {
        VStack {
            Image("plato1")
                .resizable()
                .frame(width: size, height: 200 * (size/210))
                .clipShape(RoundedRectangle(cornerRadius: 20))
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
    CardBusinessView(business: Business(businessId: 1, businessName: "La Buena Mesa", businessAddress: "123 Gourmet Street", businessPhoneNumber: "123456789", businessStatus: 2, businessLogo: "restaurant_logo.png", businessLatitude: -8.069442, businessLongitude: -79.05701, businessAverageRating: 4.5, businessTotalReviews: 5, businessDistance: "541.14 m "), size: 210)
}
