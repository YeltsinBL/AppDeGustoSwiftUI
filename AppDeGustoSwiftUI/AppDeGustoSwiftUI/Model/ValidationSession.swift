//
//  ValidationSession.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 2/10/24.
//

import Foundation
struct ValidationSession: Identifiable, Decodable {
    let id: Int
    let username: String
    let userStatus: Int
    let iat: Int
    let exp: Int

}
