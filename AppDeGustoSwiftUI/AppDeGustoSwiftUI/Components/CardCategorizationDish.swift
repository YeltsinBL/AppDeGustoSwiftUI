//
//  CardCategorizationDish.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 9/10/24.
//

import SwiftUI

struct CardCategorizationDish: View {
    let sizeHeight: CGFloat
    let nroCategorization: Int
    var body: some View {
//        HStack{
//            ForEach(0..<5, id: \.self){nro in
//                Image(systemName: "fork.knife")
//                    .foregroundStyle(nro < nroCategorization ? .black :.gray)
//            }
//        }.padding(5)
        HStack{
            ForEach(0..<5, id: \.self){nro in
                Image(systemName: "fork.knife")
                    .resizable()
                    .scaledToFit()
                    .frame(height: sizeHeight)
                    .foregroundStyle(nro < nroCategorization ? .black :.gray)
            }
        }
    }
}

#Preview {
    CardCategorizationDish(sizeHeight: 25, nroCategorization: 3)
}
