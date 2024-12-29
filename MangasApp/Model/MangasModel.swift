//
//  MangasModel.swift
//  MangasApp
//
//  Created by María Pérez  on 14/12/24.
//

import Foundation

struct MangasModel: Codable  {
    let metadata: MetadataModelDTO
    let items: [MangaModel]
}

struct MangaModel: Codable, Identifiable, Hashable {
    let genres: [GenresModel]
    let mainPicture: String
    let background: String
    let themes: [ThemesModel]
    let url: String
    let id: Int
    let volumes: Int?
    let titleJapanese: String
    let endDate: String?
    let chapters: Int?
    let sypnosis: String
    let status: String
    let score: Double
    let title: String
    let startDate: String?
    let titleEnglish: String
    let authors: [AuthorsModel]
    let demographics: [DemographicsModel]
    
    var cleanURL: URL? {
        URL(string: mainPicture.replacingOccurrences(of: "\"", with: ""))
    }
}

struct GenresModel: Codable, Hashable {
    let id: UUID
    let genre: String
}

struct ThemesModel: Codable, Hashable {
    let id: UUID
    let theme: String
}

struct AuthorsModel: Codable, Hashable {
    let role: String
    let firstName: String
    let id: UUID
    let lastName: String
}

struct DemographicsModel: Codable, Hashable {
    let id: UUID
    let demographic: String
}

struct MetadataModel: Codable {
    let total: Int
    let per: Int
    let page: Int
}
