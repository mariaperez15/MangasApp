//
//  LoginRepository.swift
//  MangasApp
//
//  Created by María Pérez  on 20/1/25.
//

import Foundation

protocol LoginRepositoryProtocol: Sendable {
    func registUser(user: UserModel) async throws(NetworkError)
    func loginUser(userAuth: String) async throws(NetworkError)
    func checkUserToken() async throws
}

struct LoginRepository: LoginRepositoryProtocol{
    let apiConfig = APIConfig.shared
    
    func registUser(user: UserModel) async throws(NetworkError) {
        let (_, response) = try await URLSession.shared.getCustomData(urlRequest: .postUser(url: .registUser(), token: apiConfig.token, user: user))
        if response.statusCode != 201 {
            throw NetworkError.badStatusCode(response.statusCode)
        }
    }
    
    func loginUser(userAuth: String) async throws(NetworkError) {
        let (data, response) = try await URLSession.shared.getCustomData(urlRequest: .postUser(url: .loginUser(), token: apiConfig.token, userAuth: userAuth))
        if response.statusCode == 200 {
            KeyChainManager.shared.storeKey(key: data, label: "userToken")
            print("Token guardado")
            print(String(data: data, encoding: .utf8))
        } else {
            throw NetworkError.badStatusCode(response.statusCode)
        }
    }
    
    func checkUserToken() async throws {
        guard let userToken = KeyChainManager.shared.readKey(label: "userToken"),
              let tokenString = String(data: userToken, encoding: .utf8) else {
            throw NetworkError.unauthorized
        }
        let (data, response) = try await URLSession.shared.data(for: .checkUserRegister(url: .renewUsersToken(), token: apiConfig.token, userToken: tokenString))
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.nonHTTP
        }
        
        if response.statusCode == 200 {
            KeyChainManager.shared.storeKey(key: data, label: "userToken")
        } else {
            throw NetworkError.badStatusCode(response.statusCode)
        }
    }
    
}
