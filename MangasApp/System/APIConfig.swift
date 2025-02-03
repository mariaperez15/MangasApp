//
//  APIConfig.swift
//  MangasApp
//
//  Created by María Pérez  on 14/1/25.
//

import Foundation

actor APIConfig {
    static let shared  = APIConfig()
    private let manager = KeyChainManager.shared
    
    var token: String?
    
    private init() {
        Task {
            try? await recoverAppToken()
        }
        print("He cogido el token apiconfig")
    }
    
    //private mutating func recoverAppToken() throws {
    private func recoverAppToken() throws {
        guard let url = Bundle.main.url(forResource: "APIConfig", withExtension: ".plist") else {
            return
        }
        let data = try Data(contentsOf: url)
        let plist = try PropertyListDecoder().decode([String:String].self, from: data)
        token = plist["App-Token"]
    }
    
    func readUserToken() -> String? {
        guard let data = manager.readKey(label: "userToken") else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    func logout() async {
        manager.deleteKey(label: "userToken")
        setToken(nil) 
        print("User logged out successfully.")
    }

    private func setToken(_ value: String?) {
        token = value
    }
    
}
