//
//  Repository.swift
//  MangasApp
//
//  Created by María Pérez  on 14/12/24.
//

import Foundation

protocol MangasRepositoryProtocol {
    func getAllMangas(page: String) async throws(NetworkError) -> MangasModel
    func getMangaContains(name: String) async throws(NetworkError) -> MangasModel
    func getMangaBy(orderBy: String, selectedFilter: String, page: String) async throws(NetworkError) -> MangasModel
    func getFilterOptions(selectedFilter:String) async throws(NetworkError) -> [String]
    func getBestMangas(page: String) async throws(NetworkError) -> MangasModel
    func registUser(email: String, password: String) async throws(NetworkError) -> String
}

struct MangasRepository: MangasRepositoryProtocol, NetworkRepositoryProtocol {
    let apiConfig = APIConfig.shared
    
    func getAllMangas(page: String) async throws(NetworkError) -> MangasModel {
        try await getJSON(model: MangasModelDTO.self, urlRequest: .getMangasRequest(url: .getAllMangas(page: page))).mapToModel
    }
    
    func getMangaContains(name: String) async throws(NetworkError) -> MangasModel {
        try await getJSON(model: MangasModelDTO.self, urlRequest: .getMangasRequest(url: .searchMangaContains(name: name))).mapToModel
    }
    
    func getMangaBy(orderBy: String, selectedFilter: String, page: String) async throws(NetworkError) -> MangasModel {
        try await getJSON(model: MangasModelDTO.self, urlRequest: .getMangasRequest(url: .getManbasBy(orderBy: orderBy, selectedFilter: selectedFilter, page: page))).mapToModel
    }
    
    func getFilterOptions(selectedFilter: String) async throws(NetworkError) -> [String] {
        try await getJSON(model: [String].self, urlRequest: .getMangasRequest(url: .getFilterOptions(selectedFilter: selectedFilter)))
    }
    
    func getBestMangas(page: String) async throws(NetworkError) -> MangasModel {
        try await getJSON(model: MangasModelDTO.self, urlRequest: .getMangasRequest(url: .getBestMangas(page: page))).mapToModel
    }
    
    func registUser(email: String, password: String) async throws(NetworkError) -> String {
        try await getJSON(model: String.self, urlRequest: .postUser(url: .registUser(), token: apiConfig.token, email: email, password: password))
    }
}

