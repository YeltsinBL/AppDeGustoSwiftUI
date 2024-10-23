//
//  SplashScreenView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 22/10/24.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Rectangle().fill(Color("Primary")).ignoresSafeArea()
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 225, height: 225)
                
                ProgressView()  // Indicador de carga
                    .progressViewStyle(CircularProgressViewStyle()).tint(.white)
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
