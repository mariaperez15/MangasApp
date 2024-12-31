//
//  MangaListComponent.swift
//  MangasApp
//
//  Created by María Pérez  on 31/12/24.
//

import SwiftUI

struct MangaListComponent: View {
    @Environment(MangasVM.self) var vm
    
    var body: some View {
        List(vm.mangas) { manga in
            NavigationLink(value: manga) {
                MangaCellComponent(manga: manga)
                    .onAppear {
                        vm.loadNextPage(manga: manga)
                    }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    MangaListComponent()
}
