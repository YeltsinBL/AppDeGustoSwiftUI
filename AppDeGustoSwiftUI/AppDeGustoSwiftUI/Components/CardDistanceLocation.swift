//
//  CardDistanceLocation.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 7/10/24.
//

import SwiftUI

struct CardDistanceLocation: View {
    let businessDistance: String
    let size: Int
    var body: some View {
        HStack(spacing: 3) {
            Image(systemName: "mappin")
                .resizable()
                .scaledToFit()
                .frame(height: CGFloat(size))
                .fontWeight(.bold)
            Text(businessDistance).fontWeight(.bold)
                .font(.system(size: CGFloat(size)))
        }.foregroundStyle(.black)
    }
}

#Preview {
    CardDistanceLocation(businessDistance: "200 m", size: 15)
}
