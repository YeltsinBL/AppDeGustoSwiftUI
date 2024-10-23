//
//  BusinessNewView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 22/10/24.
//

import SwiftUI

struct BusinessNewView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModelDish = DishViewModel()
    @StateObject var homeData = BusinessViewModel()
    var body: some View {
        ScrollView {
            LazyVStack (alignment: .leading, spacing: 15, pinnedViews: [.sectionHeaders]){
                // Imagen
                
                GeometryReader { reader -> AnyView in
                    let offset = reader.frame(in: .global).minY
                    if -offset >= 0 {
                        DispatchQueue.main.async {
                            self.homeData.offset = -offset
                        }
                    }
                    print(offset)
                    return AnyView(
                        Image("plato1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: 250 + (offset > 0 ? offset : 0))
                            .clipShape(RoundedRectangle(cornerRadius: 2))
                            .offset(y: (offset > 0 ? -offset : 0))
                    )
                }
                .frame(height:250)
                
                // Negocio
                Section(header: CardBusinessHeaderView()) {
                    // Categorías de platos
                    ForEach(tabItems) { tab in
                        VStack(alignment: .leading, spacing: 15) {
                            Text(tab.tab)
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.bottom)
                                .padding(.leading)
                            // Platos
                            ForEach(tab.dish) { food in
                                CardDishNewView(dish: food)
                                
                            }
                            Divider().padding(.top)
                        }
                        .tag(tab.tab)
                        .overlay (
                            GeometryReader{ reader -> Text in
                                let offset = reader.frame(in: .global).minY
                                let height = UIApplication.shared.windows.first!.safeAreaInsets.top + 100
                                if offset < height && offset > 50 && homeData.selectedTab != tab.tab{
                                    DispatchQueue.main.async {
                                        self.homeData.selectedTab = tab.tab
                                    }
                                }
                                return Text("")
                            }
                        )
                    }
                }
            }
        }
        .ignoresSafeArea()
        .background(Color("Bg"))
        .overlay(
            Color("Bg")
                .frame(
                    height: UIApplication.shared.windows.first?.safeAreaInsets.top)
                .ignoresSafeArea(.all, edges: .top)
                .opacity(homeData.offset > 250 ? 1 : 0)
            ,alignment: . top
        )
        .navigationBarBackButtonHidden()
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                                .tint(Color("Primary"))
                                .padding(.all, 8)
                                .background(.white)
                                .clipShape(Circle())
                }
            }
        }
        .toolbarBackground(.hidden)
        .onAppear {
           // viewModelDish.getDishByBusiness(id: 1)
        }
        .environmentObject(homeData)
    }
}

#Preview {
    BusinessNewView()
}
