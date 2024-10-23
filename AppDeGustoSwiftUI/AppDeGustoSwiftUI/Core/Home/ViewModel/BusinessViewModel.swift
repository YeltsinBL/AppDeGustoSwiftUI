//
//  BusinessViewModel.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 3/10/24.
//

import Foundation

class BusinessViewModel: ObservableObject {
    @Published var offset: CGFloat = 0
    @Published var selectedTab = tabItems.first!.tab
    
    @Published var businessPopular: [Business] = []
    
    let decoder = JSONDecoder()
    
    /// Lista de los 5 negociones mas populares
    func getBusinessPopular() async {
        //Task {
            let url = URL(string: "\(URLPath.businessPopular.url)?latitude=-8.074157889449705&longitude=-79.05579181295246")!
            do{
                let (data, response) = try await URLSession.shared.data(from: url)
                // Verificar si la respuesta es HTTPURLResponse y manejar errores HTTP
                guard let httpResponse = response as? HTTPURLResponse else {
                    print( APIError.invalidResponse)
                    return
                }
                // Decodificar los datos JSON
                let results = try decoder.decode([Business].self, from: data)
                DispatchQueue.main.async {
                    self.businessPopular = results
                }
            } catch {
                print("getBusinessPopular Solicitud rechazada")
            }
       // }
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
