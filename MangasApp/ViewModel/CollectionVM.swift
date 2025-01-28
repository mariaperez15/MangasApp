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
    //hacer como con el user cuando se pasa en el register
    var manga: Int = 0 //aqui hay que poner 0 o nada?
    var completeCollection: Bool = false
    var volumesOwned: [Int] = []
    var readingVolume: Int = 0
    
    init(repository: CollectionRepositoryProtocol = CollectionRepository()) {
        self.repository = repository
    }
    
    func getUserCollection() async {
        do {
           collection = try await repository.getUserCollection()
            //print(collection)
        } catch {
            print("collection vm error:\(error)")
        }
    }
    
    func addMangaToCollection() async {
        let collectionToAdd = CollectionModel(manga: manga, completeCollection: completeCollection, volumesOwned: volumesOwned, readingVolume: readingVolume)
        do {
            try await repository.postMangaToCollection(collection: collectionToAdd)
        } catch {
            print("adding collection error:\(error)")
        }
    }
}
