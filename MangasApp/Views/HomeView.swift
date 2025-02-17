//
//  HomeView.swift
//  MangasApp
//
//  Created by María Pérez  on 31/12/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(LoginVM.self) var vm
    
    var body: some View {
        TabView {
            Tab {
                BestMangasView()
            } label: {
                Label("Best mangas", systemImage: "book.fill")
            }
            Tab {
                CollectionView()
            } label: {
                Label("Collections", systemImage: "books.vertical.fill")
            }
            Tab {
                FiltersView()
            } label: {
                Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
            }
            Tab {
                Button {
                    Task {
                        await vm.logOut()
                    }
                } label: {
                    Label("Log out", systemImage: "power")
                        .foregroundColor(.red)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            } label: {
                Label("Settings", systemImage: "gear")
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(CollectionVM.init())
        .environment(MangasVM.preview)
        .environment(LoginVM.preview)
}
