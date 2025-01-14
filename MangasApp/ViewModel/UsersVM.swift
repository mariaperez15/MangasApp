//
//  UsersViewModel.swift
//  MangasApp
//
//  Created by María Pérez  on 14/1/25.
//

import Foundation

@Observable
final class UsersVM {
    var email: String = ""
    var password: String = ""
    let repository: MangasRepositoryProtocol
    
    init(repository: MangasRepositoryProtocol = MangasRepository()) {
        self.repository = repository
    }
    
    func registUser() async {
        do {
            let regist = try await repository.registUser(email: email, password: password)
            print(regist)
        } catch {
            print(error)
        }
    }
}
