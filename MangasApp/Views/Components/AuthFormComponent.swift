//
//  AuthFormComponent.swift
//  MangasApp
//
//  Created by María Pérez  on 20/1/25.
//

import SwiftUI

struct AuthFormComponent: View {
    var title: String
    var buttonText: String
    
    @Environment(LoginVM.self) var vm
    
    var body: some View {
        @Bindable var bvm = vm
        Text(title)
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.top, 80)
        Spacer()
        VStack (spacing: 20){
            TextField("Email", text: $bvm.email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 5)
            SecureField("Password", text: $bvm.password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 5)
        }
        .padding()
        Button {
            Task {
                await vm.registUser()
            }
        } label: {
            Text(buttonText)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
        }
        .padding(.horizontal)
        .padding(.top, 20)
        
        Spacer()
    }
}

#Preview {
    AuthFormComponent(title: "Log in", buttonText: "Log in")
}
