//
//  ContentView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 23/09/24.
//

import SwiftUI

struct ContentView: View {
//    @EnvironmentObject var viewModel: AuthViewModel
    @StateObject var viewModel = AuthViewModel()
    @State private var isLoading = true
    var body: some View {
        Group {
            if isLoading {
                // Mostrar el splash screen mientras se carga
                SplashScreenView()
            } else {
                if viewModel.userSession != nil {
                    NavigationView {
                        HomeView().environmentObject(viewModel)
                    }
                }else {
                    LoginView()
                }
//                NavigationView {
//                    HomeView().environmentObject(viewModel)
//                }
            }
        }
        .onAppear {
            Task {
                _ = await viewModel.validationSession()
                withAnimation {
                    isLoading = false
                }
            }
            
        }
    }
}

#Preview {
    ContentView().environmentObject(AuthViewModel())
}
