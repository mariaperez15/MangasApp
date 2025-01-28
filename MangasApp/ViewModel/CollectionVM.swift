//
//  CollectionVM.swift
//  MangasApp
//
//  Created by María Pérez  on 23/1/25.
//

import Foundation

@MainActor
@Observable
final class CollectionVM {
    let repository: CollectionRepositoryProtocol
    var collection: userCollection = []
    
    init(repository: CollectionRepositoryProtocol = CollectionRepository()) {
        self.repository = repository
    }
    
    func getUserCollection() async {
        do {
           collection = try await repository.getUserCollection()
            print(collection)
        } catch {
            print("collection vm error:\(error)")
        }
    }
}
