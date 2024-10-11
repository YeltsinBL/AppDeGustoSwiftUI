//
//  Complementary.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 11/10/24.
//

import Foundation

struct Complementary: Identifiable {
    let dishId:Int
    let dishName:String
    let dishDescription:String
    let dishPrice:Double
    var dishPhoto: String
    // Hacer que 'userId' sea el identificador
    var id: Int {
        return dishId
    }
}
