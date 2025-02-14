//
//  UsersViewModel.swift
//  MangasApp
//
//  Created by María Pérez  on 14/1/25.
//

import Foundation

@MainActor
@Observable
final class LoginVM {
    let repository: LoginRepositoryProtocol
    var email: String = ""
    var password: String = ""
    var isUserLogged = false
    var showAlertLoginError = false
    var showAlertErrorRegister = false
    var registerOkAlert = false
    var isLoginCompleted = false

    
    init(repository: LoginRepositoryProtocol = LoginRepository()) {
        self.repository = repository
        checkIfUserIsLogged()
    }
    
    func registUser() async {
        let user = UserModel(email: email, password: password)
        do {
            try await repository.registUser(user: user)
            showAlertErrorRegister = false
            registerOkAlert = true
        } catch {
            print("register error:\(error)")
            showAlertErrorRegister = true
            registerOkAlert = false
        }
    }
    
    func loginUser() async {
        let credentials = "\(email):\(password)"
        guard let encodedCredentials = credentials.data(using: .utf8) else {
            return
        }
        let auth = "Basic \(encodedCredentials.base64EncodedString())"
        do {
            try await repository.loginUser(userAuth: auth)
            isUserLogged = true
            showAlertLoginError = false
        } catch {
            print("Error login user: \(error)")
            isUserLogged = false
            showAlertLoginError = true
        }
    }
    
    func logOut() async {
        await APIConfig.shared.logout()
        isUserLogged = false
    }
    
    func checkIfUserIsLogged() {
        Task {
            do {
                try await repository.checkUserToken()
                isUserLogged = true
            } catch {
                isUserLogged = false
            }
        }
    }
    
}
