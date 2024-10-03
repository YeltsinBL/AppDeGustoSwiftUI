//
//  Login.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 2/10/24.
//

import Foundation

struct Login: Identifiable, Decodable {
    let userId:Int
    let userName:String
    let userStatus:Int
    // Hacer que 'userId' sea el identificador
    var id: Int {
        return userId
    }
}
