//
//  ReservationView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 24/11/24.
//

import SwiftUI

struct ReservationView: View {
    @State private var nroPersona=""
    @State private var email=""
    @State private var phoneNumber=""
    @State private var userName=""
    @State private var password=""
    @State private var confirmPassword = ""
    @State private var saveReservation = false
    @State private var offsetValue: CGFloat = 0
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var cartManager:CartManager
    @EnvironmentObject var authViewModel:AuthViewModel
    let textFormatter = TextFormatter()
    
    var body: some View {
        ZStack {
            Color("Bg")
                .ignoresSafeArea(edges: .all)
            ScrollView {
                VStack {
                    VStack(alignment:.leading, spacing: 24) {
                        Text("Fecha")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .font(.caption2)
                        Text(cartManager.formatoFecha())
                            .font(.system(size: 18)).textContentType(.none)
                        Divider()
                        Text("Total")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .font(.caption2)
                        Text(textFormatter.priceFormatter( Float(cartManager.totalPrice)))
                                .font(.system(size: 18)).textContentType(.none)
                        Divider()
                        Text("Restaurante")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .font(.caption2)
                        Text(cartManager.business?.businessName ?? "No se encontro restaurante")
                                .font(.system(size: 18)).textContentType(.none)
                        Divider()
                        Text("Cantidad de Personas")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .font(.caption2)
                        TextField("Ingrese la cantidad de asistentes", text: $nroPersona, prompt: Text("Ingrese la cantidad de asistentes"))
                            .font(.system(size: 18)).textContentType(.none)
//                        Divider()
                        //}
//                        Text("Total  \(textFormatter.priceFormatter( Float(cartManager.totalPrice)))")
//                        Text("Restaurante \(cartManager.business?.businessId ?? 0) \(cartManager.business?.businessName ?? "No se encontro restaurante")")
//                        Text("Usuario \(authViewModel.userSession?.id ?? 0) \(authViewModel.userSession?.username ?? "No se encontro usuario")")
//                        InputView(text: $nroPersona, title: "Nro. Personas", placeholder: "Cantidad de personas a asistir")
                    }
                    .frame(width: UIScreen.main.bounds.width - 60)
                    .padding(.horizontal)
                    .padding(.top, 12)
                    Button {
                        Task {
                            try saveReservation = await cartManager.saveSales(
                                reservationNumberPeople: Int(nroPersona) ?? 0,
                                reservation_UserId: authViewModel.userSession?.id ?? 0)
                            if(saveReservation) {
                                dismiss()
                            }
                        }
                    } label: {
                        HStack {
                            Text("Reservar")
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.right")
                        }
                        .foregroundStyle(.white)
                        .frame(width: UIScreen.main.bounds.width - 60, height: 48)
                    }
                    .background(Color("Primary"))
                    .cornerRadius(10)
                }
                .padding(30)
                .frame(width: UIScreen.main.bounds.width - 40, height: 645)
                //.background(.gray.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .offset(y: -self.offsetValue)  // Ajusta el desplazamiento cuando aparece el teclado
            }
            .foregroundStyle(.black).bold()
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Reservaciones")
                .toolbar{
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            dismiss()
                        }) {
                            ImageButtonBackView()
                        }
                    }
                }
        //        .toolbarBackground(.hidden)
                .padding(.top)
        }
    }
}

#Preview {
    ReservationView()
        .environmentObject(CartManager())
        .environmentObject(AuthViewModel())
}
