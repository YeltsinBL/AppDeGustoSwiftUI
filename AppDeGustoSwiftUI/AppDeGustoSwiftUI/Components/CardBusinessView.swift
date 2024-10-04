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
                    HStack {
                        Image(systemName: "star.fill").foregroundStyle(business.businessAverageRating >= 4.5 ? .yellow : .gray)
                        Text("\(business.businessAverageRating, specifier: "%.1f")").fontWeight(.bold)
                    }.padding(5).background(business.businessAverageRating >= 4.5 ? .yellow.opacity(0.2) : .gray.opacity(0.2)).clipShape(RoundedRectangle(cornerRadius: 50))
                Text("(\(business.businessTotalReviews))").fontWeight(.light).foregroundStyle(.gray).padding(.bottom, 2)
                
                
                Spacer()
                Image(systemName: "mappin").fontWeight(.bold).foregroundStyle(.blue)
                Text(business.businessDistance)
                    .font(.system(size: 18))
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
