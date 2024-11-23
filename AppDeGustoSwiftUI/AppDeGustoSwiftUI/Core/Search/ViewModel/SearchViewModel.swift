//
//  SearchViewModel.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 3/11/24.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var businessSearch: [Business] = []
    
    let decoder = JSONDecoder()
    
//    init() {
//        Task {
//            await searchBusiness("pollo")
//        }
//        
//    }
    
    func searchBusiness(_ description: String) async {
        let url = URL(string: "\(URLPath.businesSearch.url)?latitude=-8.074157889449705&longitude=-79.05579181295246&search=\(description)")! //
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
            // Verificar si la respuesta es HTTPURLResponse y manejar errores HTTP
            guard let httpResponse = response as? HTTPURLResponse else {
                print( APIError.invalidResponse)
                return
            }
            // Decodificar los datos JSON
            let results = try decoder.decode([Business].self, from: data)
            print(results)
            DispatchQueue.main.async {
                self.businessSearch = results
            }
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
            print("searchBusiness: Solicitud rechazada")
            // Manejar cualquier error relacionado con la red
            print("Error en la solicitud: \(APIError.requestFailed(error))")
        }
    }
}
