//
//  URLRequest.swift
//  MangasApp
//
//  Created by María Pérez  on 27/12/24.
//

import Foundation

extension URLRequest {
    static func getMangasRequest(url: URL) -> URLRequest {
        return URLRequest(url: url)
    }
    
    static func postUser(url: URL, token: String?, email: String, password: String) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token {
            request.setValue(token, forHTTPHeaderField: "App-Token")
            print(token)
        }
        
        let body: [String:String] = [
            "email": email,
            "password": password
        ]
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: body) {
            request.httpBody = jsonData
        } else {
            //TODO: aqui habría que lanzar error o vale con el print o no hay que tener este else?
            print("Error al convertir el cuerpo a JSON")
        }
        print(body)
        return request
    }
}
