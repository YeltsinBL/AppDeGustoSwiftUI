//
//  SideMenuView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 14/10/24.
//

import SwiftUI

struct SideMenuView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Binding var presentSideMenu: Bool
    @State  var selectedOption: SideMenuRowType?
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 36) {
                HStack{
                    Image(systemName: "person.circle.fill")
                        .imageScale(.large)
                        .foregroundStyle(.white)
                        .frame(width: 60, height:  60)
                        .background(Color("Primary"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.vertical)
                    VStack(alignment:.leading, spacing: 6) {
                        Text(viewModel.userSession?.username ?? "")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                        Text(viewModel.userSession?.personEmail ?? "")
                            .font(.subheadline)
                            .tint(.gray)
                    }
                }.padding(.horizontal)
                VStack(alignment: .leading) {
                    ForEach(SideMenuRowType.allCases, id: \.rawValue){ row in
                        if (row == .business) {
                            NavigationLink(destination: {
                                BusinessNewView()
                            }) {
                                SideMenuRowView(sideMenuRowType: SideMenuRowType.business, selectedOption: $selectedOption)
                            }
                        } else
                        if (row == .profile) {
                            NavigationLink(destination: {
                                UserView()
                            }) {
                                SideMenuRowView(sideMenuRowType: row, selectedOption: $selectedOption)
                            }
                        }
                        else if row == .checkHistory {
                            NavigationLink(destination: {
                                SearchView()
                            }) {
                                SideMenuRowView(sideMenuRowType: row, selectedOption: $selectedOption)
                            }
                        }
                        else if row == .logout {
                            Button {
                                Task {
                                    await viewModel.signOut()
                                }
                            } label:{
                                SideMenuRowView(sideMenuRowType: row, selectedOption: $selectedOption)
                            }
                        } else {
                            SideMenuRowView(sideMenuRowType: row, selectedOption: $selectedOption)
                        }
                    }
                }
            }
        }
        .background(Color("Bg"))
        .scrollClipDisabled()
        .scrollIndicators(.hidden)
        }
}

#Preview {
    SideMenuView( presentSideMenu: .constant(true), selectedOption: .profile).environmentObject(AuthViewModel())
}
