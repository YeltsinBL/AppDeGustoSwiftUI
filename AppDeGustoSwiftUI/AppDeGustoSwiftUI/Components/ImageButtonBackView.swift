//
//  ButtonBackView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 1/11/24.
//

import SwiftUI

struct ImageButtonBackView: View {
    var body: some View {
        Image(systemName: "chevron.backward")
                    .tint(Color("Primary"))
                    .padding(.all, 8)
                    .background(.white)
                    .clipShape(Circle())
    }
}

#Preview {
    ImageButtonBackView()
}
