//
//  MangaDetail.swift
//  MangasApp
//
//  Created by María Pérez  on 29/12/24.
//

import SwiftUI

struct MangaDetailComponent: View {
    @Environment(CollectionVM.self) var vm
    let manga: MangaModel
    @State var expandSynopsis = false
    
    var body: some View {
        @Bindable var bvm = vm
        ScrollView {
            VStack() {
                mangaImage
                HStack {
                    mangaTitle
                        .padding()
                    if !vm.isInCollection(id: manga.id) {
                        Button {
                            vm.isSheetPresented.toggle()
                        } label: {
                            Image(systemName: "plus.square.fill")
                                .font(.title)
                        }
                    } else {
                        Button {
                            vm.isShowingDeleteAlert.toggle()
                        } label: {
                            Image(systemName: "trash.slash")
                                .font(.title)
                        }
                        .alert("Do you want to delete manga from collection?", isPresented: $bvm.isShowingDeleteAlert) {
                            Button("Cancelar", role: .cancel) { }
                            Button("Eliminar", role: .destructive) {
                                Task {
                                    await vm.deleteMangaFromCollection(id: manga.id)
                                }
                            }
                        }
                    }
                }
                mangaSypnosis
                Button {
                    expandSynopsis.toggle()
                } label: {
                    Text(expandSynopsis ? "Hide" : "Show more")
                }
                
            }
            .animation(.smooth, value: expandSynopsis)
            .sheet(isPresented: $bvm.isSheetPresented) {
                AddMangaSheetView(mangaId: manga.id)
            }
        }
        .ignoresSafeArea(edges: .top)
    }
    
    private var mangaImage: some View {
        AsyncImage(url: manga.cleanURL) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .cornerRadius(12)
                .clipped()
        } placeholder: {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .cornerRadius(12)
        }
        .background(ignoresSafeAreaEdges: .top)
        .shadow(radius: 10)        
    }
    private var mangaTitle: some View {
        Text(manga.title)
            .font(.title)
            .bold()
    }
    private var mangaSypnosis: some View {
        Text(manga.sypnosis)
            .font(.body)
            .padding(.horizontal)
            .foregroundColor(.secondary)
            .lineLimit(expandSynopsis ? nil : 2)
    }
}

#Preview {
    MangaDetailComponent(manga: .mangaPreview)
        .environment(CollectionVM.init())
}
