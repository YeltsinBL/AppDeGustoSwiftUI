//
//  CardAverageRatingView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 3/11/24.
//

import SwiftUI

struct CardAverageRatingView: View {
    let businessAverageRating: Float?
    let size: CGFloat
    var body: some View {
//        HStack {
//            HStack {
//                Image(systemName: "star.fill")
//                    .foregroundStyle(businessAverageRating ?? 0 >= 4.5 ? .yellow : .gray)
//                Text("\(businessAverageRating ?? 0, specifier: "%.1f")").foregroundStyle(.black).fontWeight(.bold)
//            }
////            .padding(5).background(businessAverageRating ?? 0 >= 4.5 ? .yellow.opacity(0.2) : .gray.opacity(0.2))
////                .clipShape(RoundedRectangle(cornerRadius: 50))
//        }
//        .frame(width: 100)
        HStack(spacing:6) {
            Image(systemName: "star.fill")
                .resizable()
                .scaledToFit()
                .frame(height: size)
                .foregroundStyle(businessAverageRating ?? 0 >= 4.5 ? .yellow : .gray)
            Text("\(businessAverageRating ?? 0, specifier: "%.1f")").fontWeight(.bold)
                .font(.system(size: size))
        }
    }
}

#Preview {
    CardAverageRatingView(businessAverageRating: 4.5, size: 18)
}
