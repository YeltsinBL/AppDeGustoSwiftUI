//
//  RegistrationView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 23/09/24.
//

import SwiftUI

struct RegistrationView: View {
    @State private var fullName=""
    @State private var email=""
    @State private var password=""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFill()
                .frame(width: 100,height: 100)
                .padding(.vertical, 32)
            VStack(spacing: 24) {
                InputView(text: $email, title: "Nombres", placeholder: "Nombre Completo")
                InputView(text: $email, title: "Usuario", placeholder: "username")
                    .textInputAutocapitalization(.none)
                InputView(text: $password, title: "Contraseña", placeholder: "Ingresa tu contraseña", isSecureField: true)
                InputView(text: $confirmPassword, title: "Confirmar Contraseña", placeholder: "Ingresa tu contraseña", isSecureField: true)
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            Button {
                Task {
                    try await viewModel.createUser(fullName:fullName,
                                                   withUserName:email,
                                                   password:password)
                }
            } label: {
                HStack {
                    Text("Registrarse")
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
            
            Button {
                dismiss()
            } label: {
                HStack {
                    Text("Ya tienes una cuenta?")
                    Text("Inicia Sesión")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }
        }
    }
}

#Preview {
    RegistrationView()
}
