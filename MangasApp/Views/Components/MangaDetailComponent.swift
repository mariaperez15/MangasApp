//
//  MangaDetail.swift
//  MangasApp
//
//  Created by María Pérez  on 29/12/24.
//

import SwiftUI

struct MangaDetailComponent: View {
    let manga: MangaModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 60) {
                mangaImage
                Spacer()
                VStack {
                    mangaTitle
                    mangaSypnosis
                }
            }
        }
        .ignoresSafeArea(edges: .top)
    }
    
    private var mangaImage: some View {
        AsyncImage(url: manga.cleanURL) { image in
            image
                .resizable()
                .scaledToFill()
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
        .frame(height: 350)

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
    }
}

#Preview {
    MangaDetailComponent(manga: .mangaPreview)
}
