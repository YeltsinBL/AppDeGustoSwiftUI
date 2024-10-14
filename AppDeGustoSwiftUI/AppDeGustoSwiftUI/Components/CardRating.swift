//
//  CardRating.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 7/10/24.
//

import SwiftUI

struct CardRating: View {
    let businessAverageRating: Float?
    let businessTotalReviews: Int
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "star.fill")
                    .foregroundStyle(businessAverageRating ?? 0 >= 4.5 ? .yellow : .gray)
                Text("\(businessAverageRating ?? 0, specifier: "%.1f")").fontWeight(.bold)
            }.padding(5).background(businessAverageRating ?? 0 >= 4.5 ? .yellow.opacity(0.2) : .gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 50))
        Text("(\(businessTotalReviews))").fontWeight(.light)
                .foregroundStyle(.gray).padding(.bottom, 2)
        }
        .frame(width: 100)
    }
}

#Preview {
    CardRating(businessAverageRating: 4.5, businessTotalReviews: 5)
}
