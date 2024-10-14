//
//  User.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 23/09/24.
//

import Foundation

struct User: Identifiable,  Decodable {
    let userId:Int
    let userName:String
    let personName: String
    let personEmail: String
    let personPhoneNumber: String
    let personTypeName: String
    let userStatus: Int
    let userCreatedAt: String
    
    var id: Int {
        return userId
    }
}
