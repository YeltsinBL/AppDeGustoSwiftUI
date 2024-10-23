//
//  TabDish.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 22/10/24.
//

import Foundation

struct TabDish: Identifiable {
    var id = UUID().uuidString
    var tab: String
    var dish: [Dish]
}

var food = [
    Dish(dishId: 1, dishName: "Plato1", dishDescription: "PPlato de prueba 1", dishPrice: 28, dishPhoto: "plato1.png"),
    Dish(dishId: 2, dishName: "Plato2", dishDescription: "PPlato de prueba 2", dishPrice: 28, dishPhoto: "plato1.png"),
    Dish(dishId: 3, dishName: "Plato3", dishDescription: "PPlato de prueba 3", dishPrice: 28, dishPhoto: "plato1.png"),
    Dish(dishId: 4, dishName: "Plato4", dishDescription: "PPlato de prueba 4", dishPrice: 28, dishPhoto: "plato1.png"),
]

var tabItems: [TabDish] = [
    TabDish(tab: "Order Again", dish: food.shuffled()),
    TabDish(tab: "Picked", dish: food.shuffled()),
    TabDish(tab: "Start", dish: food.shuffled()),
    TabDish(tab: "Gimpub 2", dish: food.shuffled()),
    TabDish(tab: "Gimpub 3", dish: food.shuffled()),
    TabDish(tab: "Gimpub 4", dish: food.shuffled()),
    TabDish(tab: "Gimpub 5", dish: food.shuffled())
    
]
