//
//  BusinessAreas.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 2/10/24.
//

import Foundation

struct BusinessAreas: Identifiable, Decodable {
    let businessAreaId: Int
    let businessAreaName: String
    
    // Esto define el identificador para el protocolo Identifiable
    var id: Int {
        return businessAreaId
    }

    // Usamos CodingKeys para asegurarnos de mapear correctamente las claves JSON a las propiedades de Swift
    enum CodingKeys: String, CodingKey {
        case businessAreaId = "businessAreaId"
        case businessAreaName = "businessAreaName"
    }
}
