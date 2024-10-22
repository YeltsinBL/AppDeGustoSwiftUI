//
//  SideBarAction.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 21/10/24.
//

import Foundation

enum SideMenuRowType: Int, CaseIterable{
    case profile
    case checkHistory
    case logout
    
    var title: String{
        switch self {
        case .profile:
            return "Cuenta"
        case .checkHistory:
            return "Historial"
        case .logout:
            return "Cerrar Sesión"
        }
    }
    
    var iconName: String{
        switch self {
        case .profile:
            return "person.circle.fill"
        case .checkHistory:
            return "checkmark.rectangle.stack.fill"
        case .logout:
            return "arrow.backward.to.line"
        }
    }
}
extension SideMenuRowType: Identifiable {
    var id: Int { rawValue }
}
