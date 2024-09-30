//
//  AppDeGustoSwiftUIApp.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 23/09/24.
//

import SwiftUI

@main
struct AppDeGustoSwiftUIApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
