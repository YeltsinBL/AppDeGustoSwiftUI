//
//  SideMenuRowView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 14/10/24.
//

import SwiftUI

struct SideMenuRowView: View {
    let sideMenuRowType:SideMenuRowType
    @Binding var selectedOption: SideMenuRowType?
    private var isSelected: Bool {
        selectedOption == sideMenuRowType
    }
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                HStack(spacing: 20){
                    Rectangle()
                        .fill(isSelected ? Color("Primary") : Color("Bg"))
                        .frame(width: 5)
                    ZStack{
                        Image(systemName:sideMenuRowType.iconName)
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 26, height: 26)
                    }
                    .frame(width: 30, height: 30)
                    Text(sideMenuRowType.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .foregroundColor(isSelected ? .black : .gray)
                .contentShape(.rect)
            }
        }
        .frame(height: 50)
        .background(
            LinearGradient(colors: [isSelected ? Color("Primary").opacity(0.5) : Color("Bg"), Color("Bg")], startPoint: .leading, endPoint: .trailing)
        )
    }
}

#Preview {
    SideMenuRowView(sideMenuRowType: .profile, selectedOption: .constant(.profile))
}
