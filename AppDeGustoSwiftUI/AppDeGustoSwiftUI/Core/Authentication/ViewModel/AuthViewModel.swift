//
//  AuthViewModel.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 24/09/24.
//

import Foundation

class AuthViewModel: ObservableObject {
    @Published var userSession=""
    @Published var currentUser=""
    
    init() {
        
    }
    
    func signIn(withUserName userName:String, password:String) async throws {
        print("Iniciar Sesión")
    }
    func createUser(fullName: String, withUserName userName: String, password: String) async throws {
        print("Registrarse")
    }
    func signOut() {
        
    }
    func deleteAccount() {
        
    }
    func fetchUser() async {
        
    }
}
