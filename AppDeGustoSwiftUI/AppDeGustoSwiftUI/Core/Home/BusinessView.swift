//
//  BusinessView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 30/09/24.
//

import SwiftUI
import Foundation

struct BusinessView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            ZStack {
                Color("Bg")
                    .ignoresSafeArea(.all)
                ScrollView {
                    Image("plato1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    DescriptionView()
                        .offset(y: -50)
                }
                .ignoresSafeArea(.all)
                
            }
            .navigationBarBackButtonHidden(true)
            .toolbar{
                
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.backward")
                            .tint(Color("Primary"))
                            .padding(.all, 12)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
        }
    }
}

#Preview {
    BusinessView()
}

struct DescriptionView: View {
    var body: some View {
        VStack (alignment: .center) {
            Text("Restaurante 1")
                .font(.title)
                .fontWeight(.bold)
            HStack (spacing: 4) {
                ForEach(0 ..< 5) { item in
                    Image("star")
                }
                Text("(4.9)")
                    .opacity(0.5)
                    .padding(.leading, 8)
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .padding(.top)
        .background(Color("Bg"))
        .clipShape(RoundedRectangle(cornerRadius: 40))
        
        Text("Platos Recomendados")
            .font(.custom("IstokWeb-Bold", size: 24))
            .padding(.horizontal)
            .padding(.top)
        ScrollView (.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0 ..< 5) { item in
                    CardDishView(name: "Plato \(item + 1)", description: "Descripcion de todos los platos para visualizarlo cuando se esta en el restaurante y el propio plato", image: Image("plato\(item+1)"), price: "30", size: 170)
                }
                .padding(.trailing)
            }
        }
        .padding(.leading)
        .padding(.trailing)
    }
}
