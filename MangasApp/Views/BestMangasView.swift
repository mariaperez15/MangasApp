//
//  BestMangasView.swift
//  MangasApp
//
//  Created by María Pérez  on 31/1/25.
//

import SwiftUI

struct BestMangasView: View {
    @Environment(MangasVM.self) var vm
    
    var body: some View {
        // NavigationStack {
        ScrollView(.horizontal) {
            VStack {
                HStack(spacing: 15) {
                    ForEach(vm.mangas) {manga in
                        //NavigationLink(value: manga){
                        AsyncImage(url: manga.cleanURL) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .cornerRadius(12)
                                .frame(width: 160)
                                .clipped()
                        } placeholder: {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .cornerRadius(12)
                        }
                        //}
                    }
                }
                .task {
                    await vm.loadBestMangas()
                }
            }
            .background(.white)
            Spacer()
        }
        //.navigationTitle("Best mangas")
        //.navigationDestination(for: MangaModel.self) { manga in
        //MangaDetailComponent(manga: manga)
        //}
    }
}
//}


#Preview {
    BestMangasView()
        .environment(MangasVM.preview)
}
