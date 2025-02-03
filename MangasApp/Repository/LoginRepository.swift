//
//  LoginRepository.swift
//  MangasApp
//
//  Created by María Pérez  on 20/1/25.
//

import Foundation

//Todo lo relacionado con las peticiones de register y login

protocol LoginRepositoryProtocol: Sendable {
    func registUser(user: UserModel) async throws(NetworkError)
    @discardableResult func loginUser(userAuth: String) async throws(NetworkError) -> String
}

struct LoginRepository: LoginRepositoryProtocol{
    let apiConfig = APIConfig.shared
    
    func registUser(user: UserModel) async throws(NetworkError) {
        let (_, response) = try await URLSession.shared.getCustomData(urlRequest: .postUser(url: .registUser(), token: apiConfig.token, user: user))
        if response.statusCode != 201 {
            throw NetworkError.badStatusCode(response.statusCode)
        }
    }
    
    @discardableResult
    func loginUser(userAuth: String) async throws(NetworkError) -> String {
        let (data, response) = try await URLSession.shared.getCustomData(urlRequest: .postUser(url: .loginUser(), token: apiConfig.token, userAuth: userAuth))
        if response.statusCode == 200 {
            KeyChainManager.shared.storeKey(key: data, label: "userToken")
            print("Token guardado")
            print(String(data: data, encoding: .utf8))
            //print(KeyChainManager.shared.readKey(label: "userToken"))
            //TODO: cuando vaya bien quitar que devuelva un string
            return "Usuario logeado correctamente"    
        } else {
            throw NetworkError.badStatusCode(response.statusCode)
        }
    }
    
    
}
