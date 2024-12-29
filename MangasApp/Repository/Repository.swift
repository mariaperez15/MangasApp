//
//  Repository.swift
//  MangasApp
//
//  Created by María Pérez  on 14/12/24.
//

import Foundation

protocol MangasRepositoryProtocol {
    func getData(page: String) async throws(NetworkError) -> MangasModel
    func getMangaContains(name: String) async throws(NetworkError) -> MangasModel
}

struct MangasRepository: MangasRepositoryProtocol, NetworkRepositoryProtocol {
    func getData(page: String) async throws(NetworkError) -> MangasModel {
        try await getJSON(model: MangasModelDTO.self, urlRequest: URLRequest(url: .getAllMangas(page: page))).mapToModel
    }
    
    func getMangaContains(name: String) async throws(NetworkError) -> MangasModel {
        try await getJSON(model: MangasModelDTO.self, urlRequest: URLRequest(url: .searchMangaContains(name: name))).mapToModel
    }
}

