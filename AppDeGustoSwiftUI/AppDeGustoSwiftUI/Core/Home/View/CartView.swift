//
//  CartView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 10/10/24.
//

import SwiftUI

struct CartView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var cartManager:CartManager
    @State var titulo:String
    @State var showingBottonSheet = false
    var body: some View {
        ZStack {
            Color("Bg")
                .ignoresSafeArea(edges: .all)
            ScrollView {
                if cartManager.dishes.count > 0 {
                    VStack {
                        ForEach($cartManager.dishes, id:\.id) { $dish in
                            CardProductRow(dish: dish, valor: $dish.quantity)
                                .environmentObject(cartManager)
                            Divider()
                                .background(.gray.opacity(0.2))
                        }
                        Button(action: {
                            showingBottonSheet.toggle()
                        }, label: {
                            Text("Vaciar carrito")
                                .foregroundStyle(.red)
                                .font(.footnote)
                            }).padding(.vertical)
                        CartTotalPriceView(totalPrice: cartManager.totalPrice).environmentObject(cartManager)
                    }
                }else {
                            VStack(alignment: .center) {
                                Image(systemName: "cart")
                                    .padding(.all, 8)
                                    .background(.gray.opacity(0.2))
                                    .clipShape(Circle())
                                Text("Aun no has agregado platos en tu carrito").lineLimit(2).multilineTextAlignment(.center)
                            }.padding(.top, 30).frame(width: 300)
                            
                        }
                        
                    }
                    .foregroundStyle(.black).bold()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Tu carrito")
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
        .sheet(isPresented: $showingBottonSheet) {
            MessageSheetView(showSheet: $showingBottonSheet).environmentObject(cartManager).presentationDetents([.height(250)])
        }
    }
}

struct CartTotalPriceView:View {
    let totalPrice: Double
    @EnvironmentObject var cartManager:CartManager
    var body: some View {
        VStack {
            Spacer()
            HStack {
                VStack {
                    Text("Total a pagar")
                    Text("\(totalPrice, specifier: "%.2f")").bold().font(.title2)
                }
                NavigationLink(destination: {
                   
                }) {
                    Text("Realizar reserva")
                        .frame(width:160).padding().bold()
                        .background(Color("Primary"))
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                
            }
            .padding(.horizontal)
            .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .bottom)
            .mask(RoundedRectangle(cornerRadius: 26, style: .continuous))
            .shadow(color: .black.opacity(0.15), radius: 8, x: 2, y: 6)
            .overlay(
                RoundedRectangle(cornerRadius: 26, style: .continuous)
                    .stroke(.linearGradient(colors: [.white.opacity(0.5),.white.opacity(0)], startPoint: .topLeading, endPoint: .bottomTrailing))
            )
        }
    }
}

struct MessageSheetView:View {
    @EnvironmentObject var cartManager:CartManager
    @Binding var showSheet:Bool
    var body: some View {
        VStack(alignment:.leading) {
            Text("Opps!").font(.title2).bold()
                .padding(.top, 20).padding(.trailing, 20).padding(.leading,20)
            Divider().padding()
            Text("Estás seguro que deseas eliminar todos los platos del carrito?").lineLimit(2).padding(.trailing, 20).padding(.leading,20)
            HStack {
                Button {
                    showSheet.toggle()
                    print("No eliminar")
                } label: {
                    Text("Cancelar")
                }
                .frame(width:160).padding().bold()
                .border(.gray.opacity(0.2)).foregroundStyle(.red)
                .clipShape(Capsule())
//                Spacer()
                Button{
//                    print(" Eliminar")
                    cartManager.removeAllDish()
                    showSheet.toggle()
                } label: {
                    Text("Sí, eliminar")
                }.frame(width:160).padding().bold().background(Color("Primary")).foregroundStyle(.white).clipShape(RoundedRectangle(cornerRadius: 20))
            }.padding(.top)
        }
    }
}

#Preview {
//    MessageSheetView()
//    CartView(titulo: "Tu carrito")
//        .environmentObject(CartManager())
    NavigationView {
        HomeView(viewModelDish: .init(), viewModelBusiness: .init())
    }
//    CartToolBar()
}
