//
//  UsersViewModel.swift
//  MangasApp
//
//  Created by María Pérez  on 14/1/25.
//

import Foundation

@Observable
final class LoginVM {
    var email: String = ""
    var password: String = ""
    let repository: LoginRepositoryProtocol
    
    init(repository: LoginRepositoryProtocol = LoginRepository()) {
        self.repository = repository
    }
    
    func registUser() async {
        let user = User(email: email, password: password)
        do {
            let regist = try await repository.registUser(user: user)
            print(regist)
            //si se registra y va bien, tener propiedad booleana y lanzarla como un alert y ponga usuario registrado con exito y tenga un boton que ponga ok y que me lleve al login
        } catch {
            print(error)
        }
    }
    
    func loginUser() {
        let credentials = "\(email):\(password)"
        guard let encodedCredentials = credentials.data(using: .utf8) else {
            return
        }
        let auth = "Basic \(encodedCredentials.base64EncodedString())"
        
        //luego al llamar al repository.loginUser pasarle el auth en vez del user (que es lo que he hecho en el register)
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
 7. Comprobación de si he hecho bien el login (intentar añadir un manga a la colección, y luego ver si se encuentra en la colección)
 8. Alert en register si hay errror o si se ha registrado correctamente
 */

