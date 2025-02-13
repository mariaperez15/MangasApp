//
//  CollectionModel.swift
//  MangasApp
//
//  Created by María Pérez  on 23/1/25.
//

import Foundation

struct CollectionUserModel: Codable, Identifiable, Hashable {
    var id: UUID
    var volumesOwned: [Int]
    var user: UserCollectionModel
    var completeCollection: Bool
    var manga: MangaModel
    var readingVolume: Int?
}
typealias userCollection = [CollectionUserModel]

struct UserCollectionModel: Codable, Identifiable, Hashable {
    var id: UUID
}

//POST new manga
struct CollectionModel: Codable {
    var manga: Int
    var completeCollection: Bool
    var volumesOwned: [Int]
    var readingVolume: Int?
}
