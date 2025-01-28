//
//  CollectionRepository.swift
//  MangasApp
//
//  Created by María Pérez  on 20/1/25.
//

import Foundation

//Todo lo relacionado con los favoritos del usuario (obtener la lista de fav, el post de nuevo manga a la coleccion del user...)
protocol CollectionRepositoryProtocol: Sendable {
    func getUserCollection() async throws(NetworkError) -> userCollection
}

struct CollectionRepository: CollectionRepositoryProtocol, NetworkRepositoryProtocol {
    let apiConfig = APIConfig.shared
    
    func getUserCollection() async throws(NetworkError) -> userCollection {
        let token = await apiConfig.readUserToken()
        return try await getJSON(model: userCollection.self, urlRequest: .getCollection(url: .getUserCollection(), token: apiConfig.token, userToken: token))
    }
}
