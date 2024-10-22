//
//  ContentView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 23/09/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                NavigationView {
                    HomeView().environmentObject(viewModel)
                }
            }else {
                LoginView()
            }
//            HomeView()
        }
    }
}

#Preview {
    ContentView().environmentObject(AuthViewModel())
}
