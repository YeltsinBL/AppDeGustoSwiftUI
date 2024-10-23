//
//  CardBusinessHeaderView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 22/10/24.
//

import SwiftUI

struct CardBusinessHeaderView: View {
    @EnvironmentObject var homeData:BusinessViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 0) {
                Button(action: {print("Click")}) {
                    Image(systemName: "arrow.left")
                        .font(.system(size: getSize() == 0 ? getSize() : 20, weight: .bold))
                        .frame(width: getSize(), height: getSize())
                        .foregroundStyle(Color("Primary"))
                }
                Text("La buena Mesa")
                    .font(.title)
                    .fontWeight(.bold)
            }
            
            ZStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Asiatich . Koreanisch")
                                    .font(.caption)
                    HStack(spacing: 8) {
                        Image(systemName: "clock")
                            .font(.caption)
                        Text("30-40 Min")
                            .font(.caption)
                        Text("4.3")
                            .font(.caption)
                        Image(systemName: "star.fill")
                            .font(.caption)
                        Text("$6.40 Free")
                            .font(.caption)
                            .padding(.leading, 10)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }.opacity(homeData.offset > 200 ? 1 -  Double((homeData.offset - 200) / 50) : 1)
                
                // Scroll Automatico
                ScrollViewReader { reader in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(tabItems) { tab in
                                Text(tab.tab)
                                    .font(.caption)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal)
                                    .background(Color("Primary").opacity(homeData.selectedTab == tab.tab ? 1 : 0))
                                    .clipShape(Capsule())
                                    .foregroundStyle(homeData.selectedTab == tab.tab ? .white : .black)
                                    .id(tab.tab)
                            }
                            .onChange(of: homeData.selectedTab) {
                                withAnimation(.easeInOut) {
                                    reader.scrollTo(homeData.selectedTab, anchor: .leading)
                                }
                                
                            }
                        }
                    }
                    .opacity(homeData.offset > 200 ? Double((homeData.offset - 200) / 50) : 0)
                }
            }
            .frame(height: 60)
            
            
            if homeData.offset > 250 {
                Divider()
            }
        }
        .padding(.horizontal)
        .frame(height: 100)
        .background(Color("Bg"))
    }
    
    func getSize() -> CGFloat{
        
        if homeData.offset > 200 {
            let progress = (homeData.offset - 200) / 50
            if progress <= 1.0{
                return progress * 40
            }else {
                return 40
            }
        }
        else {
            return 0
        }
    }
}

#Preview {
    CardBusinessHeaderView().environmentObject(BusinessViewModel())
}
