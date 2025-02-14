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
    
    let gridColumns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                LazyVGrid(columns: gridColumns, spacing: 20) {
                    ForEach(vm.mangas) { manga in
                        VStack(spacing: 10) {
                            AsyncImage(url: manga.cleanURL) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 150, height: 200)
                                    .cornerRadius(15)
                                    .clipped()
                                    .onTapGesture {
                                        selectedManga = manga
                                        withAnimation {
                                            showPopup = true
                                        }
                                    }
                            } placeholder: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .frame(width: 150, height: 200)
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .task {
                    await vm.loadBestMangas()
                }
            }
            
            if showPopup, let selectedManga = selectedManga {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            showPopup = false
                        }
                    }
                
                VStack(spacing: 20) {
                    Text(selectedManga.title)
                        .font(.title2)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    AsyncImage(url: selectedManga.cleanURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 200, height: 300)
                    
                    Text(selectedManga.sypnosis)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Button(action: {
                        withAnimation {
                            showPopup = false
                        }
                    }) {
                        Text("Cerrar")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 100)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                    }
                }
                .frame(width: 320)
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 10)
                .transition(.scale)
            }
        }
        .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    BestMangasView()
        .environment(MangasVM.preview)
}
