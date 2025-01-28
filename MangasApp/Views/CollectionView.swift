//
//  CollectionView.swift
//  MangasApp
//
//  Created by María Pérez  on 28/1/25.
//

import SwiftUI

struct CollectionView: View {
    @Environment(CollectionVM.self) var vm
    
    var body: some View {
        NavigationStack {
            List(vm.collection) { collection in
                NavigationLink(value: collection.manga) {
                    MangaCellComponent(manga: collection.manga)
                }
            }
            .listStyle(.plain)
            .task {
               await vm.getUserCollection()
            }
            .navigationTitle("Your collection")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: MangaModel.self) { manga in
                MangaDetailComponent(manga: manga)
            }
        }
    }
}

#Preview {
    CollectionView()
        .environment(CollectionVM.init())
}
