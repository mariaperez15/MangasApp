//
//  LoginRepository.swift
//  MangasApp
//
//  Created by María Pérez  on 20/1/25.
//

import Foundation

//Todo lo relacionado con las peticiones de register y login

protocol LoginRepositoryProtocol {
    func registUser(user: User) async throws(NetworkError) -> String
}

struct LoginRepository: LoginRepositoryProtocol{
    let apiConfig = APIConfig.shared
    
    func registUser(user: User) async throws(NetworkError) -> String {
        let (_, response) = try await URLSession.shared.getCustomData(urlRequest: .postUser(url: .registUser(), token: apiConfig.token, user: user))
        if response.statusCode == 201 {
               return "Usuario creado exitosamente"
           } else {
               throw NetworkError.badStatusCode(response.statusCode)
           }
    }
    
    func loginUser(user: User) async throws(NetworkError) -> String {
        let (data, response) = try await URLSession.shared.getCustomData(urlRequest: .postUser(url: .loginUser(), token: apiConfig.token, user: user))
        if response.statusCode == 200 {
            KeyChainManager.shared.storeKey(key: data, label: "Basic Auth")
            return "Usuario logeado correctamente"
        } else {
            throw NetworkError.badStatusCode(response.statusCode)
        }
        //data lo guardare en el keychain si el status code es correcto
    }
}
