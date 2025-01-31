//
//  BestMangasView.swift
//  MangasApp
//
//  Created by María Pérez  on 31/1/25.
//

import SwiftUI

struct BestMangasView: View {
    @Environment(MangasVM.self) var vm
    @State private var showPopup = false
    @State private var selectedManga: MangaModel? = nil
    
    var body: some View {
        ZStack {
            ScrollView(.horizontal) {
                VStack{
                    HStack(spacing: 15) {
                        ForEach(vm.mangas) {manga in
                            AsyncImage(url: manga.cleanURL) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity)
                                    .cornerRadius(12)
                                    .frame(width: 160)
                                    .clipped()
                                    .onTapGesture {
                                        selectedManga = manga
                                        withAnimation {
                                            showPopup = true
                                        }
                                    }
                            } placeholder: {
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(12)
                            }
                        }
                    }
                    Spacer()
                    .task {
                        await vm.loadBestMangas()
                    }

                }
                
            }
            if showPopup, let selectedManga = selectedManga {
                Color.black.opacity(0.1)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            showPopup = false
                        }
                    }
                
                VStack {
                    Text(selectedManga.title)
                        .font(.title2)
                        .bold()
                        .padding()
                    
                    AsyncImage(url: selectedManga.cleanURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 150, height: 200)
                    Text(selectedManga.sypnosis)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button("Cerrar") {
                        withAnimation {
                            showPopup = false
                        }
                    }
                    .padding()
                }
                .frame(width: 300)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 10)
                .transition(.scale)
            }
        }
    }
}


#Preview {
    BestMangasView()
        .environment(MangasVM.preview)
}
