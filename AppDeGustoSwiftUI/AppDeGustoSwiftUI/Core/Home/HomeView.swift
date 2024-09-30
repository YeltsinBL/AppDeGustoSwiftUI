//
//  HomeView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 23/09/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        List {
            Section {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Usuario")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.top,4)
                        Text("Email")
                            .font(.footnote)
                            .tint(.gray)
                    }
                }
            }
            Section("Cuenta") {
                Button(action: {
                    print("Cerrar Sesión")
                }, label: {
                    Text("Cerrar Sesión")
                })
            }
        }
    }
}

#Preview {
    HomeView()
}
