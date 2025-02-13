//
//  LoginView.swift
//  MangasApp
//
//  Created by María Pérez  on 20/1/25.
//

import SwiftUI

struct LoginView: View {
    @Environment(LoginVM.self) var vm
    
    var body: some View {
        @Bindable var bvm = vm
        NavigationStack {
            VStack{
                AuthFormComponent(title: "Log in", buttonText: "Log in") {
                    Task {
                        await vm.loginUser()
                    }
                }
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
            .edgesIgnoringSafeArea(.all)
            .alert("Login failed", isPresented: $bvm.showAlertLoginError) {
                Button("OK", role: .cancel) {
                    vm.email = ""
                    vm.password = ""
                }
            } message: {
                Text("Your password or email is incorrect, please try again.")
            }
        }
    }
}


#Preview {
    LoginView()
        .environment(LoginVM.preview)
}
