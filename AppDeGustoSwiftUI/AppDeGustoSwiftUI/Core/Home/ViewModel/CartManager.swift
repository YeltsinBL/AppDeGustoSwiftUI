//
//  CartManager.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 10/10/24.
//

import Foundation

class CartManager: ObservableObject {
    @Published var dishes: [Dish] = []
    @Published private(set) var totalPrice: Double = 0
    
    /// Agregar platos al carrito
    /// - Parameters:
    ///   - dish: Plato a agregar
    ///   - cant: Verifica si se esta agregando desde la vista de platos o desde el carrito
    func add(_ dish: Dish, _ cant: Int = 1) {
        if let index = dishes.firstIndex(where: { $0.dishId == dish.dishId }) {
            // Si el plato ya existe, sumar la cantidad proporcionada
            dishes[index].quantity! += cant == 0 ? 0 : dish.quantity!
        } else {
            // Si el plato no existe, agregarlo a la lista
            dishes.append(dish)
        }
        // Actualiza el precio total sumando el precio del plato multiplicado por la cantidad
        totalPrice += dish.dishPrice * Double(cant == 0 ? 1 : dish.quantity!)
    }
    
    /// Restar o eliminar el plato agregado en el carrito
    /// - Parameters:
    ///   - dish: Plato a restar o eliminar
    func remove(_ dish: Dish) {
        if let index = dishes.firstIndex(where: { $0.dishId == dish.dishId }){
            // Actualiza el precio total restando el precio del plato
            totalPrice -= dish.dishPrice
            // Verifica si la cantidad es cero para eliminarlo
            if(dishes[index].quantity! == 0){
                dishes.remove(at: index)
            }
        } else {
            print("Plato no encontrado")
        }
        
    }
}
