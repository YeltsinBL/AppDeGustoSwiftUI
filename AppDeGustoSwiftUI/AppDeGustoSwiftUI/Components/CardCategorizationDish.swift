//
//  CardCategorizationDish.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 9/10/24.
//

import SwiftUI

struct CardCategorizationDish: View {
    let nroCategorization: Int
    var body: some View {
        HStack{
            ForEach(0..<5, id: \.self){nro in
                Image(systemName: "fork.knife").foregroundStyle(nro < nroCategorization ? .black :.gray)
            }
        }.padding(5)
    }
}

#Preview {
    CardCategorizationDish(nroCategorization: 3)
}
