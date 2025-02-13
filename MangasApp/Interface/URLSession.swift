//
//  URLSession.swift
//  MangasApp
//
//  Created by María Pérez  on 14/12/24.
//

import Foundation

extension URLSession {
    func getCustomData(urlRequest: URLRequest) async throws(NetworkError) -> (Data, HTTPURLResponse) {
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.nonHTTP }
            return (data, httpResponse)
        } catch {
            throw .badURLRequest(error)
        }
    }
}
