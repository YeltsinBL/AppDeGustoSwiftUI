//
//  ImageCircleSeparatorView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 3/11/24.
//

import SwiftUI

struct ImageCircleSeparatorView: View {
    let sizeWidth: CGFloat
    var body: some View {
        Image(systemName: "circle.fill")
            .resizable()
            .scaledToFit()
            .frame(width: sizeWidth).foregroundStyle(.gray.opacity(0.3))
    }
}

#Preview {
    ImageCircleSeparatorView(sizeWidth: 5)
}
