//
//  DishViewModel.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 2/10/24.
//

import Foundation

class DishViewModel: ObservableObject {
    @Published var dishCategory: [DishCategory] = []
    
    /// Lista de los Tipos de Categoria de los Platos
    func getAllDishCategory() {
        Task {
            let dishesCategories = PathURL.DishCategoryPath
            let url = URL(string: AuthViewModel.URLAPI + dishesCategories.rawValue)!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                let results = try decoder.decode([DishCategory].self, from: data)
                print("Dishes Categories: \(results)")
                dishCategory = results
            } catch {
                print("Error en la solicitud: \(APIError.requestFailed(error))")
            }
        }
    }
}
