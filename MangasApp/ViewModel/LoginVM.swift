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
    //var email: String = ""
    var email: String = "157mariap@gmail.com"
    //var password: String = ""
    var password: String = "12345678"
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
            //TODO: si se registra y va bien, tener propiedad booleana y lanzarla como un alert y ponga usuario registrado con exito y tenga un boton que ponga ok y que me lleve al login
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
            
            //TODO: ver por que al hacer el getUSerCollection coge el token anterior y no el nuevo
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




//TODO: ME falta paginar lo de get collection y no se si algo mas
//TODO: en best manga mostrar solo los 5 o 6 primeros
