//
//  Dish.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 3/10/24.
//

import Foundation

struct Dish: Identifiable, Decodable, Equatable{
    let dishId:Int
    let dishName:String
    let dishDescription:String
    let dishPrice:Double
    var dishPhoto: String
    var quantity:Int? = 0
    // Hacer que 'userId' sea el identificador
    var id: Int {
        return dishId
    }
}
