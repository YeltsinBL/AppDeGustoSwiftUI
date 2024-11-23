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
    case user
    case validateSessionPath
    case login
    case register
    case logout
    case dishPath
    case dishCategoryPath
    case dishPopular
    case dishByBusiness
    case business
    case businessPopular
    case businesSearch
    
    // Propiedad calculada para obtener la URL completa dependiendo del caso
    var url: String {
        // URL base dinámica obtenida del entorno, con un valor por defecto
        let baseURL = ProcessInfo.processInfo.environment["URLAPI"] ?? "http://localhost:3000/api/"
        
        switch self {
        case .user:
            return "\(baseURL)user"
        case .validateSessionPath:
            return "\(URLPath.user.url)/validateSession"
        case .login:
            return "\(URLPath.user.url)/login"
        case .register:
            return "\(URLPath.user.url)/register"
        case .logout:
            return "\(URLPath.user.url)/logout"
        case .dishPath:
            return "\(baseURL)dish"
        case .dishCategoryPath:
            return "\(baseURL)dish/dishCategory"
        case .dishPopular:
            return "\(URLPath.dishPath.url)/popular"
        case .dishByBusiness:
            return "\(URLPath.dishPath.url)/business"
        case .business:
            return "\(baseURL)business"
        case .businessPopular:
            return "\(URLPath.business.url)/popular"
        case .businesSearch:
            return "\(URLPath.business.url)/search"
        }
    }
}
