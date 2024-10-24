//
//  SideBarView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 20/10/24.
//

import SwiftUI

struct SideBarView: View {
    @Binding var isShowing:Bool
    var body: some View {
        ZStack {
            if isShowing {
                Rectangle()
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }
                HStack {
                    VStack {
                        SideMenuView(presentSideMenu: $isShowing)
                        Spacer()
                    }
                    .frame(width: 270, alignment: .leading)
                    .background(Color("Bg"))
                    Spacer()
                }.transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut, value: isShowing)
    }
}

#Preview {
    SideBarView(isShowing: .constant(true))
}
