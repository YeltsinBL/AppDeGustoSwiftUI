//
//  SideMenuRowView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 14/10/24.
//

import SwiftUI
enum SideMenuRowType: Int, CaseIterable{
    case home = 0
    case checkMenu
    case profile
    case logout
    
    var title: String{
        switch self {
        case .home:
            return "Home"
        case .checkMenu:
            return "Historial"
        case .profile:
            return "Cuenta"
        case .logout:
            return "Cerrar Sesión"
        }
    }
    
    var iconName: String{
        switch self {
        case .home:
            return "house.fill"
        case .checkMenu:
            return "checkmark.rectangle.stack.fill"
        case .profile:
            return "person.crop.circle.fill"
        case .logout:
            return "arrow.backward.to.line"
        }
    }
}

struct SideMenuRowView: View {
    @Binding var selectedSideMenuTab: Int
    @Binding var presentSideMenu: Bool
    var body: some View {
        HStack {
            ZStack{
                Rectangle()
                    .fill(.white)
                    .frame(width: 270)
                    .shadow(color: Color("Primary").opacity(0.1), radius: 5, x: 0, y: 3)
                
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .center){
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .overlay(Circle().stroke(Color("Primary").opacity(0.5), lineWidth: 10))
                            .cornerRadius(50)
                    }.frame(height: 140)
                        .padding(.horizontal,70)
                    
                    ForEach(SideMenuRowType.allCases, id: \.self){ row in
                        RowView(isSelected: selectedSideMenuTab == row.rawValue, imageName: row.iconName, title: row.title) {
                            selectedSideMenuTab = row.rawValue
                            presentSideMenu.toggle()
                        }
                    }
                    Spacer()
                }
//                .padding(.top, 100)
                .frame(width: 270)
                .background(
                    Color("Bg")
                )
            }
            Spacer()
        }
        .background(.clear)
    }
    func ProfileImageView() -> some View{
            VStack(alignment: .center){
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .overlay(Circle().stroke(Color("Primary").opacity(0.5), lineWidth: 10))
                    .cornerRadius(50)
            }//.background(.red)
        }
    func RowView(isSelected: Bool, imageName: String, title: String, hideDivider: Bool = false, action: @escaping (()->())) -> some View{
            Button{
                action()
            } label: {
                VStack(alignment: .leading){
                    HStack(spacing: 20){
                        Rectangle()
                            .fill(isSelected ? Color("Primary") : Color("Bg"))
                            .frame(width: 5)
                        
                        ZStack{
                            Image(systemName:imageName)
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(isSelected ? .black : .white)
                                .frame(width: 26, height: 26)
                        }
                        .frame(width: 30, height: 30)
                        Text(title)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(isSelected ? .black : .gray)
                        Spacer()
                    }
                }
            }
            .frame(height: 50)
            .background(
                LinearGradient(colors: [isSelected ? Color("Primary").opacity(0.5) : Color("Bg"), Color("Bg")], startPoint: .leading, endPoint: .trailing)
            )
        }
}

#Preview {
    @State var selectedSideMenuTab: Int = 1
    @State var presentSideMenu: Bool = false
    SideMenuRowView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu)
}
