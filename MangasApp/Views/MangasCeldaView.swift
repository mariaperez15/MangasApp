//
//  MangasCeldaView.swift
//  MangasApp
//
//  Created by María Pérez  on 27/12/24.
//

import SwiftUI

struct MangasCeldaView: View {
    let vm = MangasVM()
    let manga: MangaModel
    
    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: manga.cleanURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 130)
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
            VStack(alignment: .leading, spacing: 8) {
                Text(manga.title)
                    .font(.headline)
                    .bold()
                    .foregroundColor(.primary)
                    .lineLimit(1)
                Text(manga.sypnosis ?? "Synopsis not available")
                    .lineLimit(2)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 5)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    MangasCeldaView(manga: .mangaPreview)
}
