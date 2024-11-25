//
//  Reservations.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 24/11/24.
//


import Foundation

// Estructura de detalle de reserva
struct ReservationDetail: Encodable {
    let detail_DishId: Int
    let reservationDetailQuantity: Int
    let reservationDetailPrice: Double
}

// Estructura principal de reserva
struct Reservation: Encodable {
    let reservationId: Int
    let reservationTime: String
    let reservationNumberPeople: Int
    let reservationPaymentAmount: Double
    let reservationPhoto: String
    let reservation_UserId: Int
    let reservation_BusinessId: Int
    let reservationDetails: [ReservationDetail]
}
