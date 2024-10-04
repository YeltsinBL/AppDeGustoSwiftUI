//
//  Business.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 3/10/24.
//

import Foundation

struct Business: Identifiable, Decodable {
    let businessId: Int
    let businessName: String
    let businessAddress: String
    let businessPhoneNumber: String
    let businessStatus: Int
    let businessLogo: String
    let businessLatitude: Float
    let businessLongitude: Float
    let businessAverageRating: Float
    let businessTotalReviews: Int
    let businessDistance: String
    
    var id : Int {
        return businessId
    }
}
