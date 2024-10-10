//
//  DishViewModel.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 2/10/24.
//

import Foundation

class DishViewModel: ObservableObject {
    @Published var dishCategory: [DishCategory] = []
    @Published var dishPopular: [Dish] = []
    @Published var dishByBusiness: [Dish] = []
    
    let decoder = JSONDecoder()
    
    /// Lista de los Tipos de Categoría de los Platos
    func getAllDishCategory() {
        Task {
            let url = URL(string: AuthViewModel.URLAPI + PathURL.DishCategoryPath.rawValue)!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let results = try decoder.decode([DishCategory].self, from: data)
                dishCategory = results
            } catch {
                print("Error en la solicitud: \(APIError.requestFailed(error))")
            }
        }
    }
    
    /// Lista de los 5 platos mas populares
    /// - Parameter id: Id del tipo de Categoría de Plato
    func getPopularDish(id:Int) {
        Task {
            let url = URL(string: "\(URLPath.dishPopular.url)/\(id)")!
            do{
                let (data, _) = try await URLSession.shared.data(from: url)
                let results = try decoder.decode([Dish].self, from: data)
                let updatedResults = results.map { dish -> Dish in
                    var updatedDish = dish
                    if updatedDish.dishPhoto.hasPrefix("https") {
                        var components = updatedDish.dishPhoto.components(separatedBy: "/")
                        if components.count > 1 {
                            // Reemplaza el penúltimo componente
                            components[components.count - 2] = "c_auto,g_auto,h_172,w_180"
                            // Reconstruir la cadena
                            let newPath = components.joined(separator: "/")
                            updatedDish.dishPhoto = newPath.lowercased()
                        }
                    }
                    return updatedDish
                }
                dishPopular = updatedResults
            } catch {
                print("Solicitud rechazada")
            }
        }
    }
    
    /// Lista de los  platos por su negocio
    /// - Parameter id: Id del negocio de los platos
    func getDishByBusiness(id:Int) {
        Task {
            let url = URL(string: "\(URLPath.dishByBusiness.url)/\(id)")!
            do{
                let (data, _) = try await URLSession.shared.data(from: url)
                let results = try decoder.decode([Dish].self, from: data)
                dishByBusiness = results
                print(dishByBusiness)
            } catch {
                print("Solicitud rechazada")
            }
        }
    }
}
