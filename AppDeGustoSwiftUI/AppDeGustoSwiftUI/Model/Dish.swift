//
//  Dish.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 3/10/24.
//

import Foundation

struct Dish: Identifiable, Decodable{
    let dishId:Int
    let dishName:String
    let dishDescription:String
    let dishPrice:Double
    let dishPhoto: String
    // Hacer que 'userId' sea el identificador
    var id: Int {
        return dishId
    }
}
