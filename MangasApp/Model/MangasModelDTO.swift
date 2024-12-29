//
//  MangasModel.swift
//  MangasApp
//
//  Created by María Pérez  on 14/12/24.
//

import Foundation

struct MangasModelDTO: Codable  {
    let metadata : MetadataModelDTO
    let items: [MangaModelDTO]
    
    var mapToModel: MangasModel {
        MangasModel(
            metadata: metadata,
            items: items.map(\.mapToModel)
        )
    }
}

struct MangaModelDTO: Codable, Identifiable {
    let genres: [GenresModelDTO]
    let mainPicture: String
    let background: String?
    let themes: [ThemesModelDTO]
    let url: String
    let id: Int
    let volumes: Int?
    let titleJapanese: String?
    let endDate: String?
    let chapters: Int?
    let sypnosis: String?
    let status: String
    let score: Double
    let title: String
    let startDate: String?
    let titleEnglish: String?
    let authors: [AuthorsModelDTO]
    let demographics: [DemographicsModelDTO]
    
    var cleanURL: URL? {
        URL(string: mainPicture.replacingOccurrences(of: "\"", with: ""))
    }
    
    var mapToModel: MangaModel {
        MangaModel(
            genres: genres.map(\.mapToModel),
            mainPicture: mainPicture,
            background: background ?? "Background not available",
            themes: themes.map(\.mapToModel),
            url: url,
            mangaID: id,
            volumes: volumes,
            titleJapanese: titleJapanese ?? "Title japanese not available",
            endDate: endDate,
            chapters: chapters,
            sypnosis: sypnosis ?? "Synopsis not available",
            status: status,
            score: score,
            title: title,
            startDate: startDate,
            titleEnglish: titleEnglish ?? "Title english not available",
            authors: authors.map(\.mapToModel),
            demographics: demographics.map(\.mapToModel)
        )
    }
}

struct GenresModelDTO: Codable {
    let id: UUID
    let genre: String
    
    var mapToModel: GenresModel {
        GenresModel(
            id: id,
            genre: genre
        )
    }
}

struct ThemesModelDTO: Codable {
    let id: UUID
    let theme: String
    
    var mapToModel: ThemesModel {
        ThemesModel(
            id: id,
            theme: theme
        )
    }
}

struct AuthorsModelDTO: Codable {
    let role: String
    let firstName: String
    let id: UUID
    let lastName: String
    
    var mapToModel: AuthorsModel {
        AuthorsModel(
            role: role,
            firstName: firstName,
            id: id,
            lastName: lastName
        )
    }
}

struct DemographicsModelDTO: Codable {
    let id: UUID
    let demographic: String
    
    var mapToModel: DemographicsModel {
        DemographicsModel(
            id: id,
            demographic: demographic
        )
    }
}

struct MetadataModelDTO: Codable {
    let total: Int
    let per: Int
    let page: Int
    
    var mapToModel: MetadataModel {
        MetadataModel(
            total: total,
            per: per,
            page: page
        )
    }
}
