//
//  RegisterView.swift
//  MangasApp
//
//  Created by María Pérez  on 14/1/25.
//

import SwiftUI

struct RegisterView: View {
    @Environment(LoginVM.self) var vm
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            AuthFormComponent(title: "Register", buttonText: "Register")
            HStack {
                Text("don't have an account?")
                    .foregroundColor(.gray)
                
                Button {
                    dismiss()
                } label: {
                    Text("Log in")
                        .fontWeight(.bold)
                        .foregroundColor(Color.blue)
                }
            }
            .padding(.bottom, 40)
        }        
        .background(Color(.systemGray5))
    }
    
}


#Preview {
    RegisterView()
        .environment(LoginVM.preview)
}
