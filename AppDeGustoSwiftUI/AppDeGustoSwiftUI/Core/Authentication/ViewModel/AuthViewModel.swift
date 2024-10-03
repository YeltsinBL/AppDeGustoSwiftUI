//
//  AuthViewModel.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 24/09/24.
//

import Foundation

class AuthViewModel: ObservableObject {
    @Published var userSession: ValidationSession?
    @Published var currentUser=""
    let mockJSON = """
    {
      "id": 0,
      "username": "alice_johnson",
      "userStatus": 0,
      "iat": 0,
      "exp": 0
    }
    """.data(using: .utf8)!
    static let URLAPI = ProcessInfo.processInfo.environment["URLAPI"] ?? "http://localhost:3000/api/"
    
    init() {
        Task {
            self.userSession = await validationSession()
        }
    }
    /// Validar si esta la Sesión activa del usuario
    /// - Returns: Datos de la sesion o nulo
    func validationSession() async -> ValidationSession? {
        
        let businessareas = "user/validateSession"
        
        // Validar si la URL es correcta
        guard let url = URL(string: AuthViewModel.URLAPI + businessareas) else {
            print( APIError.invalidURL)
            return nil
        }
        do {
            // Simular que si esta validado el usuario
//            let decoder = JSONDecoder()
//            let valideSession = try decoder.decode(ValidationSession.self, from: mockJSON)
//            print("Validation Session: \(valideSession)")
//            return valideSession
//            
            // Realizar la solicitud
            let (data, response) = try await URLSession.shared.data(from: url)
            // Verificar si la respuesta es HTTPURLResponse y manejar errores HTTP
            guard let httpResponse = response as? HTTPURLResponse else {
                print( APIError.invalidResponse)
                return nil
            }
            // Verificar el código de estado HTTP
            if (200...299).contains(httpResponse.statusCode) {
                // Decodificar los datos JSON
                let decoder = JSONDecoder()
                let valideSession = try decoder.decode(ValidationSession.self, from: data)
                print("Validation Session: \(valideSession)")
                return valideSession
            } else {
                // Intentar leer el cuerpo de la respuesta para obtener el mensaje de error
                if let responseBody = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let message = responseBody["message"] as? String {
                    print( APIError.serverError(statusCode: httpResponse.statusCode, message: message))
                    return nil
                } else {
                    print( APIError.serverError(statusCode: httpResponse.statusCode, message: nil))
                    return nil
                }
            }
        } catch {
            // Manejar cualquier error relacionado con la red
            print( APIError.requestFailed(error))
            return nil
        }
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
    func verifyResponse (response: URLResponse, data: Data) {
        // Verificar si la respuesta es una HTTPURLResponse
        if let httpResponse = response as? HTTPURLResponse {
            if (200...299).contains(httpResponse.statusCode) {
                // Intentar convertir los datos a JSON (o el formato que esperes)
                if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) {
                    print("Respuesta en formato JSON: \(jsonObject)")
                } else if let responseString = String(data: data, encoding: .utf8) {
                    // Si no es JSON, intenta imprimir la respuesta como texto
                    print("Respuesta en formato texto: \(responseString)")
                } else {
                    // Si no es JSON ni texto, puedes ver los datos en bruto
                    print("Datos recibidos (brutos): \(data)")
                }
            } else {
                // Intentar leer el cuerpo de la respuesta para obtener el mensaje de error
                if let responseBody = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let message = responseBody["message"] as? String {
                    print("APIError con mensaje: \(APIError.serverError(statusCode: httpResponse.statusCode, message: message))")
//                    throw APIError.serverError(statusCode: httpResponse.statusCode, message: message)
                } else {
                    print("APIError sin mensaje: \(APIError.serverError(statusCode: httpResponse.statusCode, message: nil))")
//                    throw APIError.serverError(statusCode: httpResponse.statusCode, message: nil)
                }
            }
        }
    }
    
    func businessAreasList() async throws {
        Task{
            let businessareas = "businessareas"
            do {
                // Intentar realizar la solicitud
                let (data, _) = try await URLSession.shared.data(from: URL(string: AuthViewModel.URLAPI + businessareas)!)
                // Decodificar los datos JSON en tu modelo BusinessAreas
                let decoder = JSONDecoder()
                let businessAreas = try decoder.decode([BusinessAreas].self, from: data)
                print("Business area: \(businessAreas)")
            } catch let error as APIError {
                // Manejar cada tipo de error
                switch error {
                case .invalidURL:
                    print("Error: La URL proporcionada es inválida.")
                case .requestFailed(let networkError):
                    print("Error en la solicitud de red: \(networkError.localizedDescription)")
                case .invalidResponse:
                    print("Error: Respuesta no válida del servidor.")
                case .serverError(let statusCode, let message):
                    if statusCode == 403 {
                        print("Error \(statusCode): \(message ?? "Acceso denegado.")")
                    } else {
                        print("Error del servidor: Código de estado \(statusCode), Mensaje: \(message ?? "No disponible.")")
                    }
                case .decodingFailed(let decodingError):
                    print("Error al decodificar el JSON: \(decodingError.localizedDescription)")
                case .unknownError:
                    print("Error desconocido.")
                }
                
            } catch {
                // Manejar cualquier error relacionado con la red
                print("Error en la solicitud: \(APIError.requestFailed(error))")
            }
        }
    }
}
