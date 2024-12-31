//
//  PreviewData.swift
//  MangasApp
//
//  Created by María Pérez  on 27/12/24.
//

import Foundation

struct PreviewDataRepository: MangasRepositoryProtocol {
    func getFilterOptions(selectedFilter: String) async throws(NetworkError) -> [String] {
        let url = Bundle.main.url(forResource: "PreviewData", withExtension: "json")!
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([String].self, from: data)
        } catch {
            throw .badJSONDecoder(error)
        }
    }
    
    func getMangaBy(orderBy: String, selectedFilter: String) async throws(NetworkError) -> MangasModel {
        let url = Bundle.main.url(forResource: "PreviewData", withExtension: "json")!
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(MangasModel.self, from: data)
        } catch {
            throw .badJSONDecoder(error)
        }
    }
    
    func getMangaContains(name: String) async throws(NetworkError) -> MangasModel {
        let url = Bundle.main.url(forResource: "PreviewData", withExtension: "json")!
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(MangasModel.self, from: data)
        } catch {
            throw .badJSONDecoder(error)
        }
    }
    
    func getAllMangas(page: String) async throws(NetworkError) -> MangasModel {
        let url = Bundle.main.url(forResource: "PreviewData", withExtension: "json")!
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(MangasModel.self, from: data)
        } catch {
            throw .badJSONDecoder(error)
        }
    }
}

extension MangasVM {
    static let preview = MangasVM(repository: PreviewDataRepository())
}

extension MangaModel {
    static let mangaPreview: MangaModel = MangaModel(
        genres: [
            GenresModel(id: UUID(uuidString: "4C13067F-96FF-4F14-A1C0-B33215F24E0B")!, genre: "Award Winning"),
            GenresModel(id: UUID(uuidString: "4312867C-1359-494A-AC46-BADFD2E1D4CD")!, genre: "Drama"),
            GenresModel(id: UUID(uuidString: "97C8609D-856C-419E-A4ED-E13A5C292663")!, genre: "Mystery")
        ],
        mainPicture: "https://cdn.myanimelist.net/images/manga/3/258224l.jpg",
        background: "Monster won the Grand Prize at the 3rd annual Tezuka Osamu Cultural Prize in 1999, as well as the 46th Shogakukan Manga Award in the General category in 2000.",
        themes: [
            ThemesModel(id: UUID(uuidString: "840867E7-6C60-49CE-8C47-A99AA71A2113")!, theme: "Adult Cast"),
            ThemesModel(id: UUID(uuidString: "4394C99F-615B-494A-929E-356A342A95B8")!, theme: "Psychological")
        ],
        url: "https://myanimelist.net/manga/1/Monster",
        id: 1,
        volumes: 18,
        titleJapanese: "MONSTER",
        endDate: "2001-12-20T00:00:00Z",
        chapters: 162,
        sypnosis: "Kenzou Tenma, a renowned Japanese neurosurgeon working in post-war Germany, faces a difficult choice: to operate on Johan Liebert, an orphan boy on the verge of death, or on the mayor of Düsseldorf. In the end, Tenma decides to gamble his reputation by saving Johan, effectively leaving the mayor for dead.",
        status: "finished",
        score: 9.15,
        title: "Monster",
        startDate: "1994-12-05T00:00:00Z",
        titleEnglish: "Monster",
        authors: [
            AuthorsModel(
                role: "Story & Art",
                firstName: "Naoki",
                id: UUID(uuidString: "54BE174C-2FE9-42C8-A842-85D291A6AEDD")!,
                lastName: "Urasawa"
            )
        ],
        demographics: [
            DemographicsModel(
                id: UUID(uuidString: "CE425E7E-C7CD-42DB-ADE3-1AB9AD16386D")!,
                demographic: "Seinen"
            )
        ]
    )

}
