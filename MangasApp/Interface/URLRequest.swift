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
    
    static func postUser(url: URL, token: String?, user: User? = nil, userAuth: String? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token {
            request.setValue(token, forHTTPHeaderField: "App-Token")
        }
        
        if let user {
            do {
                let jsonData = try JSONEncoder().encode(user)
                request.httpBody = jsonData
            } catch {
                print("Error al codificar JSON: \(error)")
            }
        }
        
        if let userAuth {
            request.setValue(userAuth, forHTTPHeaderField: "Authorization")
        }
        
        
        return request
    }
    
}
