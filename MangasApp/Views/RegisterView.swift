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
        @Bindable var bvm = vm
        VStack{
            AuthFormComponent(title: "Register", buttonText: "Register") {
                Task {
                    await vm.registUser()
                }
            }
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
        .edgesIgnoringSafeArea(.all)
        .alert("Registration failed", isPresented: $bvm.showAlertErrorRegister) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("The data entered is invalid, please try again.")
        }
        .alert("Registration Success", isPresented: $bvm.registerOkAlert) {
            Button("OK") {
                dismiss()
                vm.email = ""
                vm.password = ""
            }
        } message: {
            Text("Registration completed. You can now log in.")
        }
    }
}


#Preview {
    RegisterView()
        .environment(LoginVM.preview)
}
