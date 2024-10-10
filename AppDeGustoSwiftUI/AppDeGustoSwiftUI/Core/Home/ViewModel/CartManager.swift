//
//  CartManager.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 10/10/24.
//

import Foundation

class CartManager: ObservableObject {
    @Published private(set) var dishes: [Dish] = []
    @Published private(set) var totalPrice: Double = 0
    
    func add(_ dish: Dish) {
        dishes.append(dish)
        totalPrice += dish.dishPrice
    }
    func remove(_ dish: Dish) {
        print(dish)
        dishes = dishes.filter{ $0.id != dish.id }
        totalPrice -= dish.dishPrice
    }
}
