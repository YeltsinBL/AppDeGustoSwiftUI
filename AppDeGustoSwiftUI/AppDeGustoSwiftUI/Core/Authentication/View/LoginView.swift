//
//  LoginView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 23/09/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email=""
    @State private var password=""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100,height: 100)
                    .padding(.vertical, 32)
                VStack(spacing: 24) {
                    InputView(text: $email, title: "Usuario", placeholder: "username")
                        .textInputAutocapitalization(.none)
                    InputView(text: $password, title: "Contraseña", placeholder: "Ingresa tu contraseña", isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                Button {
                    Task {
                        try await viewModel.signIn(withUserName: email, password: password)
                    }
                } label: {
                    HStack {
                        Text("Iniciar Sesión")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundStyle(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemBlue))
                .cornerRadius(10)
                .padding(.top, 24)
                
                Spacer()
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                }label: {
                    HStack {
                        Text("No tienes una cuenta?")
                        Text("Regístrate")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
