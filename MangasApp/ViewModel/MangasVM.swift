//
//  MangasViewModel.swift
//  MangasApp
//
//  Created by María Pérez  on 14/12/24.
//

import Foundation
import SwiftUI

enum Filters: String, CaseIterable, Identifiable {
    var id: Self {self}
    
    case all = "All"
    case genre = "By genre"
    case theme = "By theme"
    case demographic = "By demographic"
    case bestMangas = "Best mangas"
    
    var description: String {
        switch self {
        case .all:
            "Show all mangas"
        case .genre:
            "Filter by genre"
        case .theme:
            "Filter by theme"
        case .demographic:
            "Filter by demographics"
        case .bestMangas:
            "Show best mangas"
        }
    }
}

@Observable
final class MangasVM {
    let repository: MangasRepositoryProtocol
    var mangas: [MangaModel] = []
    var mangasInfo: MangasModel?
    var page: Int = 1
    var searchedText = ""
    var currentFilter: Filters = .all
    var selectedSubfilter: String = ""
    var filterOptions: [String] = []
    
    
    init(repository: MangasRepositoryProtocol = MangasRepository()) {
        self.repository = repository
    }
    
    func resetMangas() {
        mangas.removeAll()
        page = 1
    }
    
    func loadMangas() async {
        if searchedText.isEmpty {
            switch currentFilter {
            case .all:
                await loadAllMangas()
            case .genre:
                await loadMangasBy(orderBy: "Genre", param: selectedSubfilter)
            case .theme:
                await loadMangasBy(orderBy: "Theme", param: selectedSubfilter)
            case .demographic:
                await loadMangasBy(orderBy: "Demographic", param: selectedSubfilter)
            case .bestMangas:
                await loadBestMangas()
            }
        } else {
            await loadSearchedMangas()
        }
    }
    
    func loadAllMangas() async {
        do {
            let data = try await repository.getAllMangas(page: String(page))
            self.mangasInfo = data
            print("pagina: \(page)")
            mangas += data.items
        } catch {
            print(error)
        }
    }
    
    func loadSearchedMangas() async {
        do {
            mangas.removeAll()
            let data = try await repository.getMangaContains(name: searchedText)
            self.mangasInfo = data
            mangas += data.items
        } catch {
            print(error)
        }
    }
    
    func loadImage(manga: MangaModel) async -> UIImage {
        let cleanedURL = manga.mainPicture.replacingOccurrences(of: "\"", with: "")
        let imageSystem = UIImage(systemName: "photo") ?? UIImage()
        do {
            guard let imgURL = URL(string: cleanedURL) else {
                return imageSystem
            }
            let data = try Data(contentsOf: imgURL)
            guard let image = UIImage(data: data) else {
                return imageSystem
            }
            return image
        } catch {
            print("Error al cargar la imagen: \(error)")
            return UIImage(systemName: "photo") ?? UIImage()
        }
    }
    
    func isLast(manga: MangaModel) -> Bool {
        mangas.last?.id == manga.id
    }
    
    func loadNextPage(manga: MangaModel) {
        guard let mangasInfo = mangasInfo else {
            return
        }
        if page < mangasInfo.metadata.total {
            if isLast(manga: manga) {
                page += 1
                print("Sumar pagina!")
                Task {
                    await loadMangas()
                }
            }
        }
    }
    
    func setFilter(filter: Filters?, optionSelected: String?) {
        if let filter = filter {
            currentFilter = filter
        }
        if let optionSelected = optionSelected {
            selectedSubfilter = optionSelected
        }
        //mirar si aquí hay que resetear o no esto
        resetMangas()
        Task {
            await loadMangas()
        }
    }
    
    func loadMangasBy(orderBy: String, param: String) async {
        do {
            mangas.removeAll()
            let data = try await repository.getMangaBy(orderBy: orderBy, selectedFilter: param)
            self.mangasInfo = data
            mangas += data.items
        } catch {
            print(error)
        }
    }
    
    func loadFilterOptions(filter: Filters) async {
        do {
            if currentFilter != filter{
                resetMangas()
                currentFilter = filter
            }
            filterOptions.removeAll()
            print("filterOptions: \(filterOptions)")
            print("currentFilter.rawValue: \(currentFilter.rawValue)")
            let filterSelected = String(currentFilter.rawValue.split(separator: " ")[1]) + "s"
            filterOptions = try await repository.getFilterOptions(selectedFilter: filterSelected)
        } catch {
            print(error)
        }
    }
    
    func loadBestMangas() async {
        do {
            mangas.removeAll()
            let data = try await repository.getBestMangas()
            self.mangasInfo = data
            mangas += data.items
        } catch {
            print(error)
        }
    }
    
}

