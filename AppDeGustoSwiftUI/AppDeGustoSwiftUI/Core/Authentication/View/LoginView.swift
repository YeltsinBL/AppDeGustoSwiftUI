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
            ZStack {

                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                    
                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200,height: 150)
                        .padding(.vertical, 32)
                    
                    VStack {
                        VStack(spacing: 24) {

                            InputView(text: $email, title: "Usuario", placeholder: "Ingresa tu usuario")
                                .textInputAutocapitalization(.none)
                            InputView(text: $password, title: "Contraseña", placeholder: "Ingresa tu contraseña", isSecureField: true)
                        }
                        .frame(width: UIScreen.main.bounds.width - 60)
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
                            .frame(width: UIScreen.main.bounds.width - 60, height: 48)
                        }
                        .background(Color("Primary"))
                        .cornerRadius(10)
                        .padding(.top, 24)
                        
                        }
                        .padding(30)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 310)
                        .background(.gray.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
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
                        .tint(.white)
                        .font(.system(size: 16))
                    }
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
