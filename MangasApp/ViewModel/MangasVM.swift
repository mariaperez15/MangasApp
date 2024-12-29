//
//  MangasViewModel.swift
//  MangasApp
//
//  Created by María Pérez  on 14/12/24.
//

import Foundation
import SwiftUI

@Observable
final class MangasVM {
    let repository: MangasRepositoryProtocol
    var mangas: [MangaModel] = []
    var mangasInfo: MangasModel?
    var page: Int = 1
    var searchedText = ""
    
    
    init(repository: MangasRepositoryProtocol = MangasRepository()) {
        self.repository = repository
    }
    
    func resetMangas() {
        mangas.removeAll()
        page = 1
    }
    
    func loadMangas() async {
        if searchedText.isEmpty {
            await loadAllMangas()
        } else {
            await loadSearchedMangas()
        }
    }
    
    func loadAllMangas() async {
            do {
                let data = try await repository.getData(page: String(page))
                self.mangasInfo = data
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
                Task {
                    await loadMangas()
                }
            }
        }
    }    
}

