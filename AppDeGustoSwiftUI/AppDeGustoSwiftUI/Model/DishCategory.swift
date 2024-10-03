//
//  DishCategory.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 2/10/24.
//

import Foundation

struct DishCategory: Identifiable, Decodable {
    let dishCategoryID: Int
    let dishCategoryName: String
    var id: Int {
        return dishCategoryID
    }
}
