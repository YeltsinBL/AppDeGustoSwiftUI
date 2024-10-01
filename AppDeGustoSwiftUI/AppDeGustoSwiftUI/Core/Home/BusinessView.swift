//
//  BusinessView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 30/09/24.
//

import SwiftUI
import Foundation

struct BusinessView: View {
    var body: some View {
        VStack {
            ZStack {
                Color("Bg")
                    .ignoresSafeArea(.all)
                VStack {
                    Image("plato1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .ignoresSafeArea(.all)
                    
                    DescriptionView()
                        .offset(y: -50)
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
                Spacer()
            }
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
