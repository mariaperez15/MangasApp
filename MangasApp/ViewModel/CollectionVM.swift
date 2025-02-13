//
//  CollectionVM.swift
//  MangasApp
//
//  Created by María Pérez  on 23/1/25.
//

import Foundation

@MainActor
@Observable
final class CollectionVM {
    let repository: CollectionRepositoryProtocol
    var collection: userCollection = []
    var isSheetPresented = false
    var manga: Int = 0
    var completeCollection: Bool = false
    var volumesOwned: [Int] = []
    var readingVolume: Int = 0
    var isShowingDeleteAlert = false
    
    init(repository: CollectionRepositoryProtocol = CollectionRepository()) {
        self.repository = repository
    }
    
    func getUserCollection() async {
        do {
           collection = try await repository.getUserCollection()
        } catch {
            print("collection vm error:\(error)")
        }
    }
    
    func addMangaToCollection() async {
        let collectionToAdd = CollectionModel(manga: manga, completeCollection: completeCollection, volumesOwned: volumesOwned, readingVolume: readingVolume)
        do {
            try await repository.postMangaToCollection(collection: collectionToAdd)
            resetValues()
            isSheetPresented.toggle()
            await getUserCollection()
        } catch {
            print("adding collection error:\(error)")
        }
    }
    
    func resetValues() {
        manga = 0
        completeCollection = false
        volumesOwned = []
        readingVolume = 0
    }
    
    func deleteMangaFromCollection(id: Int) async {
        do {
            try await repository.deleteMangaFromCollection(mangaId: id)
            await getUserCollection()
        } catch {
            
        }
    }
    
    func isInCollection(id: Int) -> Bool {
        collection.contains { collection in
            collection.manga.id == id
        }
    }
}
