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
    let collectionvM = CollectionVM()
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
            await collectionvM.getUserCollection()
            isUserLogged = true
            showAlertLoginError = false
        } catch {
            print("Error login user: \(error)")
            isUserLogged = false
            showAlertLoginError = true
        }
    }
}


/*TODO:
 1. Login View /
 2. Crear endpoint (URL) de login
 3. crear en Login Repository la func logoinUser (pasar al login el app-token como en el register)
 4. Guardar en el keychain el token
 5. Alert si los datos son invalidos (alert en el libro de las vistas)
 ______
 6. Al dar al login, tenemos que decirle al inicio de la app que el usuario se ha logeado correctamente. si llega     "reason": "Unauthorized",, poner un alert de los datos no son correctos, intenelo de nuevo
 7. TODO: Comprobación de si he hecho bien el login (intentar añadir un manga a la colección, y luego ver si se encuentra en la colección)
 */

/*
 1. crear metodo de refresh token (pasar token actual y ahi sabre si es okey y me dara uno nuevo en ese caso y sino no se)
 2. hacer renew cada vez que se abra la app
 (si el token esta caducado, es decir devuelve un 401, habrá que mandar al usuario al login de nuevo
 3. Como hacer que persista, es decir que no vuelva a pasar por el login si ya esta registrado
 */



//TODO: Opción de log out
/*
 1. En el detalle, añadir un boton de "añadir manga a la colección (no es un post,
 2. crear grid view para elegir el user los mangas que tiene
 */

//TODO: ultimo que he hecho jueves 23 es intentar hacer el getuserCollection pero me da error porque coge el token anterior

//TODO: zanjar el tema de postear un manga, dandole a un boton de añadir a colección y que ahi se haga el post
/*
 1. boton en el detalle que sea agregar a mi colección. Este boton deberá desplegar algo tipo un sheet, que ponga volumesOwned, por cual va lyendo y debajo un boton de confirm que cuando se le pulse, llamara a un metodo del VM que añadira un manga a la colección (pasando el id del manga, poner el volumes owned y por cual va que seran dos variables published en la vista y por ultimo el complete collection (manga.volumes si es == volumesOwned.count, para sacar el bool)
 2. una vez añadido a la colección, tendra que bajar el sheeet y el boton ya no pondra añadir a la colección sino quitar de la colección.
 */
