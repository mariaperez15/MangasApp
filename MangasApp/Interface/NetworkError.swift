//
//  NetworkError.swift
//  MangasApp
//
//  Created by María Pérez  on 14/12/24.
//

import Foundation

enum NetworkError: Error {
    case nonHTTP
    case badURL
    case badURLRequest(Error)
    case badStatusCode(Int)
    case badJSONDecoder(Error)
    case unauthorized
}
