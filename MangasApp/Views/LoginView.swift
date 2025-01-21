//
//  LoginView.swift
//  MangasApp
//
//  Created by María Pérez  on 20/1/25.
//

import SwiftUI

struct LoginView: View {
    
    var body: some View {
        NavigationStack {
            VStack{
                AuthFormComponent(title: "Log in", buttonText: "Log in")
                HStack {
                    Text("don't have an account?")
                        .foregroundColor(.gray)
                    
                    NavigationLink(destination: RegisterView()) {
                        Text("Register")
                            .fontWeight(.bold)
                            .foregroundColor(Color.blue)
                    }
                    
                }
                .padding(.bottom, 40)
            }
            .background(Color(.systemGray5))
            //.edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    LoginView()
        .environment(LoginVM.preview)
}
