//
//  APIError.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 2/10/24.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed(Error) // Error de red
    case invalidResponse
    case serverError(statusCode: Int, message: String?) // Error HTTP con mensaje opcional
    case decodingFailed(Error) // Error al decodificar JSON
    case unknownError
}
