//
//  MangaDetail.swift
//  MangasApp
//
//  Created by María Pérez  on 29/12/24.
//

import SwiftUI

struct MangaDetailComponent: View {
    let manga: MangaModel
   @State var expandSynopsis = false
    
    var body: some View {
        ScrollView {
            VStack() {
                mangaImage
                mangaTitle
                mangaSypnosis
                Button {
                    expandSynopsis.toggle()
                } label: {
                    Text(expandSynopsis ? "Hide" : "Show more")
                }

            }
            .animation(.smooth, value: expandSynopsis)
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
        //.frame(height: 300)
        
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
}
