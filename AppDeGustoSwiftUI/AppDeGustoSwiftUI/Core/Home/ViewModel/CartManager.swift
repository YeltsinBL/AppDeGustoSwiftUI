//
//  CartManager.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 10/10/24.
//

import Foundation

class CartManager: ObservableObject {
    @Published var dishes: [Dish] = []
    @Published private(set) var totalPrice: Double = 0
    @Published var currentDate = Date()
    @Published var business: Business?
    
    /// Agregar platos al carrito
    /// - Parameters:
    ///   - dish: Plato a agregar
    ///   - cant: Verifica si se esta agregando desde la vista de platos o desde el carrito
    func add(_ dish: Dish, _ business: Business?,_ cant: Int = 1) {
        if let index = dishes.firstIndex(where: { $0.dishId == dish.dishId }) {
            // Si el plato ya existe, sumar la cantidad proporcionada
            dishes[index].quantity! += cant == 0 ? 0 : dish.quantity!
        } else {
            // Si el plato no existe, agregarlo a la lista
            dishes.append(dish)
        }
        // Actualiza el precio total sumando el precio del plato multiplicado por la cantidad
        totalPrice += dish.dishPrice * Double(cant == 0 ? 1 : dish.quantity!)
        self.business = business
    }
    
    /// Restar o eliminar el plato agregado en el carrito
    /// - Parameters:
    ///   - dish: Plato a restar o eliminar
    func remove(_ dish: Dish) {
        if let index = dishes.firstIndex(where: { $0.dishId == dish.dishId }){
            // Actualiza el precio total restando el precio del plato
            totalPrice -= dish.dishPrice
            // Verifica si la cantidad es cero para eliminarlo
            if(dishes[index].quantity! == 0){
                dishes.remove(at: index)
            }
        } else {
            print("Plato no encontrado")
        }
        
    }
    /// Eliminar todos los platos agregados en el carrito
    func removeAllDish() {
        dishes.removeAll()
        self.business = nil
    }
    
    /// Guardar la reserva
    /// - Parameter reservationNumberPeople: Numero de personas que iran al establecimiento
    /// - Parameter reservation_UserId: Id del usuario
    /// - Returns: Devuelve True o False para visualizar si se guardo correctamente
    func saveSales(reservationNumberPeople: Int, reservation_UserId: Int) async throws -> Bool {
        // Validar si la URL es correcta
        guard let registerUrl = URL(string: URLPath.sales.url) else {
            print( APIError.invalidURL)
            return false
        }
        // Convierte los platos al formato de detalle de reserva
        let reservationDetails = dishes.map { dish in
            ReservationDetail(
                detail_DishId: dish.dishId,
                reservationDetailQuantity: dish.quantity ?? 0,
                reservationDetailPrice: dish.dishPrice // Precio fijo
            )
        }
        // Crea el objeto de reserva
        let reservation = Reservation(
            reservationId: 0,
            reservationTime: formatoFecha(),
            reservationNumberPeople: reservationNumberPeople,
            reservationPaymentAmount: totalPrice,
            reservationPhoto: "",
            reservation_UserId: reservation_UserId,
            reservation_BusinessId: business?.businessId ?? 0,
            reservationDetails: reservationDetails
        )
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(reservation)
        let body = String(data: jsonData, encoding: .utf8)
        print("Body reserva: \(String(describing: body))")

        let result = sendReservation(json: body!, to: registerUrl) { success in
                if success {
                    print("Reserva enviada correctamente.")
                    return
                } else {
                    print("Error al enviar la reserva.")
                    return
                }
            }
        print(result)
        removeAllDish()
        return true
    }
    
    /// Realiza la Peticion al servidor
    /// - Parameters:
    ///   - json: Valores formateados de acuerdo a lo que pide la API
    ///   - url: URL de la API
    ///   - completion: Devuelve true o false
    func sendReservation(json: String, to url: URL, completion: @escaping (Bool) -> Void) {
        // Convierte el JSON a `Data`
        guard let jsonData = json.data(using: .utf8) else {
            print("Error al convertir el JSON a Data")
            completion(false) // Retorna falso si no se pudo convertir el JSON
            return
        }
        
        // Configura la solicitud
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Crea la tarea de red
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Manejo de errores
            if let error = error {
                print("Error al realizar la solicitud: \(error)")
                completion(false) // Retorna falso en caso de error
                return
            }
            
            // Verifica la respuesta HTTP
            if let httpResponse = response as? HTTPURLResponse {
                if (200...299).contains(httpResponse.statusCode) {
                    print("Solicitud exitosa con código: \(httpResponse.statusCode)")
                    completion(true) // Retorna verdadero si la solicitud fue exitosa
                    return
                } else {
                    print("Error en la respuesta: \(httpResponse.statusCode)")
                    completion(false) // Retorna falso si la respuesta no es exitosa
                    return
                }
            }
            
            // Si no hay datos o respuesta válida, retorna falso
            completion(false)
        }
        
        // Ejecuta la tarea
        task.resume()
    }
    func transformToReservationDetails(dishes: [Dish]) -> [ReservationDetail] {
        return dishes.map { dish in
            ReservationDetail(
                detail_DishId: dish.dishId,
                reservationDetailQuantity: dish.quantity ?? 0,
                reservationDetailPrice: dish.dishPrice * Double(dish.quantity ?? 0)
            )
        }
    }
    func formatoFecha() -> String {
        let currentDate = currentDate  // Obtiene la fecha actual
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"  // Especifica el formato deseado
        return dateFormatter.string(from: currentDate)  // Convierte la fecha a String
    }
}
