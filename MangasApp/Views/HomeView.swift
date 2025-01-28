//
//  HomeView.swift
//  MangasApp
//
//  Created by María Pérez  on 31/12/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            Tab {
                
            } label: {
                Label("Reading now", systemImage: "book.fill")
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
        }
    }
}

#Preview {
    HomeView()
}
