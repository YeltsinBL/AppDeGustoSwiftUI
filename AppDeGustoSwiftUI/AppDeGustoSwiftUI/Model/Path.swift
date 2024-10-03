//
//  Path.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 3/10/24.
//

import Foundation

enum PathURL: String {
    case ValidateSessionPath = "user/validateSession"
    case DishPath = "/dish"
    case DishCategoryPath = "dish/dishCategory"
}

enum URLPath {
    case validateSessionPath
    case dishPath
    case dishCategoryPath
    case dishPopular
    
    // Propiedad calculada para obtener la URL completa dependiendo del caso
    var url: String {
        // URL base dinámica obtenida del entorno, con un valor por defecto
        let baseURL = ProcessInfo.processInfo.environment["URLAPI"] ?? "http://localhost:3000/api/"
        
        switch self {
        case .validateSessionPath:
            return "\(baseURL)user/validateSession"
        case .dishPath:
            return "\(baseURL)dish"
        case .dishCategoryPath:
            return "\(baseURL)dish/dishCategory"
        case .dishPopular:
            return "\(URLPath.dishPath.url)/popular"
        }
    }
}
