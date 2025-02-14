//
//  MangasCeldaView.swift
//  MangasApp
//
//  Created by María Pérez  on 27/12/24.
//

import SwiftUI

struct MangaCellComponent: View {
    let manga: MangaModel
    
    var body: some View {
        HStack(spacing: 20) {
            mangasImage
            VStack(alignment: .leading, spacing: 8) {
                mangaTitle
                mangaSynopsis
            }
            Spacer()
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 5)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
    
    private var mangasImage: some View {
        AsyncImage(url: manga.cleanURL) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(width: 90)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(color: .gray.opacity(0.5), radius: 4, x: 4, y: 4)
        } placeholder: {
            ProgressView()
                .frame(width: 120, height: 140)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.gray.opacity(0.05))
                )
        }
    }
    private var mangaTitle: some View {
        Text(manga.title)
            .font(.headline)
            .bold()
            .foregroundColor(.primary)
            .lineLimit(1)
    }
    private var mangaSynopsis: some View {
        Text(manga.sypnosis)
            .lineLimit(2)
            .font(.subheadline)
            .foregroundColor(.secondary)
    }
}

#Preview {
    MangaCellComponent(manga: .mangaPreview)
}
