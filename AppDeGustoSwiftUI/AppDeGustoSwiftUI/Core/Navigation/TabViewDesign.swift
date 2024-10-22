//
//  TabView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 2/10/24.
//

import SwiftUI

struct TabViewDesign: View {
        
    var body: some View {
        VStack {
            Spacer()
            HStack {
                BottomNavBarItem(image: Image(systemName: "house.fill")) {
                    
                }
                BottomNavBarItem(image: Image(systemName: "map")) {
                    
                }
                BottomNavBarItem(image: Image(systemName: "heart")) {
                    
                }
                BottomNavBarItem(image: Image(systemName: "person")) {
                    
                }
            }
            .padding()
            .background(.white)
            .clipShape(Capsule())
            .padding(.horizontal)
            .shadow(color: .black.opacity(0.15), radius: 8, x: 2, y: 6)
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}

#Preview {
    TabViewDesign()
}

struct BottomNavBarItem: View {
    let image: Image
    let action: () -> Void
    var body: some View {
        Button(action: action, label: {
            image
                .scaledToFill()
                .tint(Color("Primary"))
                .frame(maxWidth: .infinity)
        })
    }
}
