//
//  NetworkRepository.swift
//  MangasApp
//
//  Created by María Pérez  on 26/12/24.
//

import Foundation

protocol NetworkRepositoryProtocol {
}

extension NetworkRepositoryProtocol {
    func getJSON<MODEL>(model: MODEL.Type, urlRequest: URLRequest) async throws(NetworkError) -> MODEL where MODEL:Codable {
        let (data, response) = try await URLSession.shared.getCustomData(urlRequest: urlRequest)
        print("urlRequest: \(urlRequest)")
        if response.statusCode == 200{
            do {
                return try JSONDecoder().decode(model, from: data)
            } catch {
                throw .badJSONDecoder(error)
            }
        } else {
            throw .badStatusCode(response.statusCode)
        }
    }
}
