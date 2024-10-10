//
//  TextFormatter.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 10/10/24.
//

import Foundation

struct TextFormatter {
    
    
    /// Formatear ls URL de la imagen
    /// - Parameter text: URL de la imagen
    /// - Parameter type: Verificar si es imagen del Negocio o Plato
    /// - Returns: URL formateada
    func urlFormatter(_ text: String, _ type:Int) -> String {
        if text.hasPrefix("https") {
            var components = text.components(separatedBy: "/")
            if components.count > 1 {
                // Reemplaza el penúltimo componente
                components[components.count - 3] = type == 1 ? "c_auto,g_auto,h_172,w_180":"c_crop,g_auto,h_550,w_800"
                // Reconstruir la cadena
                let newPath = components.joined(separator: "/")
                return newPath
            }
        }
        return text
    }
    
    /// Formatear el precio a dos decimales
    /// - Parameter price: el valor del precio
    /// - Returns: retorna el precio formateado en cadena
    func priceFormatter(_ price: Float) -> String {
//        return "S/\(price, specifier: "%.2f")" //Extra argument 'specifier' in call
        return String(format: "S/%.2f", price)
    }
}
