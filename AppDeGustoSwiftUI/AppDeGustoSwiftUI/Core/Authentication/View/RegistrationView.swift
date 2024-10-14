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
    @State private var phoneNumber=""
    @State private var userName=""
    @State private var password=""
    @State private var confirmPassword = ""
    @State private var session = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100,height: 80)
                VStack {
                    VStack(spacing: 24) {
                        InputView(text: $fullName, title: "Nombres", placeholder: "Nombre Completo")
                        InputView(text: $email, title: "Correo Electrónico", placeholder: "Ejm: degusto@gmail.com")
                        InputView(text: $phoneNumber, title: "Numero de Teléfono", placeholder: "Ejm: 123456789")
                        InputView(text: $userName, title: "Usuario", placeholder: "username")
                            .textInputAutocapitalization(.none)
                        InputView(text: $password, title: "Contraseña", placeholder: "Ingresa tu contraseña", isSecureField: true)
                        InputView(text: $confirmPassword, title: "Confirmar Contraseña", placeholder: "Ingresa tu contraseña", isSecureField: true)
                    }
                    .frame(width: UIScreen.main.bounds.width - 60)
                    .padding(.horizontal)
                    .padding(.top, 12)
                    Button {
                        Task {
                            try session = await viewModel.createUser(fullName: fullName, email: email, phoneNumber: phoneNumber, withUserName:email, password:password)
                            
                            if(session) {
                                dismiss()
                            }
                        }
                    } label: {
                        HStack {
                            Text("Registrarse")
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.right")
                        }
                        .foregroundStyle(.white)
                        .frame(width: UIScreen.main.bounds.width - 60, height: 48)
                    }
                    .background(Color("Primary"))
                    .cornerRadius(10)
                }
                .padding(30)
                .frame(width: UIScreen.main.bounds.width - 40, height: 645)
                .background(.gray.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
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
                    .foregroundStyle(.white)
                }
            }
        }
    }
}

#Preview {
    RegistrationView()
}
