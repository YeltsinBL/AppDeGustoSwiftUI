//
//  InputView.swift
//  AppDeGustoSwiftUI
//
//  Created by YeltsinMacPro13 on 23/09/24.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    var body: some View {
        VStack (alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundStyle(Color(.white))
                .font(.system(size: 20))
                .fontWeight(.bold)
            .font(.caption2)
        
            if isSecureField {
                SecureField(placeholder, text: $text, prompt: Text(placeholder).foregroundStyle(.white))
                    .foregroundStyle(Color(.white))
                    .font(.system(size: 18))
            }else {
                TextField(placeholder, text: $text, prompt: Text(placeholder).foregroundStyle(.white))
                    .foregroundStyle(Color(.white))
                    .font(.system(size: 18))
            }
            Divider()
        }
    }
}

#Preview {
    InputView(text: .constant(""), title: "Email", placeholder: "username")
}
