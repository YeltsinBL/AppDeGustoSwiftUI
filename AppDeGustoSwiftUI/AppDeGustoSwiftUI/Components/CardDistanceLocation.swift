//
//  CardDistanceLocation.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 7/10/24.
//

import SwiftUI

struct CardDistanceLocation: View {
    let businessDistance: String
    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: "mappin").fontWeight(.bold).foregroundStyle(.blue)
            Text(businessDistance)
                .font(.system(size: 18))
        }
    }
}

#Preview {
    CardDistanceLocation(businessDistance: "200 m")
}
