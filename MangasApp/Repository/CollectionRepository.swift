//
//  CollectionRepository.swift
//  MangasApp
//
//  Created by María Pérez  on 20/1/25.
//

import Foundation

protocol CollectionRepositoryProtocol: Sendable {
    func getUserCollection() async throws(NetworkError) -> userCollection
    func postMangaToCollection(collection: CollectionModel) async throws(NetworkError)
    func deleteMangaFromCollection(mangaId: Int) async throws(NetworkError)
}

struct CollectionRepository: CollectionRepositoryProtocol, NetworkRepositoryProtocol {
    let apiConfig = APIConfig.shared
    
    func getUserCollection() async throws(NetworkError) -> userCollection {
        let token = await apiConfig.readUserToken()
        return try await getJSON(model: userCollection.self, urlRequest: .getCollection(url: .getUserCollection(), token: apiConfig.token, userToken: token))
    }
    
    func postMangaToCollection(collection: CollectionModel) async throws(NetworkError) {
        let token = await apiConfig.readUserToken()
        let (_, response) = try await URLSession.shared.getCustomData(urlRequest: .postMangaCollection(url: .getUserCollection(), token: apiConfig.token, userToken: token, collection: collection))
       
        if response.statusCode != 201 {
            throw NetworkError.badStatusCode(response.statusCode)
        }
    }
    
    func deleteMangaFromCollection(mangaId: Int) async throws(NetworkError) {
        let token = await apiConfig.readUserToken()
        let (_, response) = try await URLSession.shared.getCustomData(urlRequest: .deleteMangaCollection(url: .deleteMangaFromCollection(mangaId: mangaId), token: apiConfig.token, userToken: token))
        if response.statusCode != 200 {
            throw NetworkError.badStatusCode(response.statusCode)
        }
    }
}
