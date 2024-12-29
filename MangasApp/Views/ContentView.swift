//
//  ContentView.swift
//  MangasApp
//
//  Created by María Pérez  on 14/12/24.
//

import SwiftUI

struct ContentView: View {
    @State var vm = MangasVM(repository: MangasRepository())
    //por que esta de abajo es privada?
    @State private var timer: Timer?
    
    var body: some View {
        NavigationStack {
            @Bindable var bvm = vm
            List(vm.mangas) { manga in
                MangasCeldaView(manga: manga)
                    .onAppear {
                        vm.loadNextPage(manga: manga)
                    }
            }
            .listStyle(.plain)
            .task {
                if vm.mangas.isEmpty {
                    await vm.loadMangas()
                }
            }
            .navigationTitle("All mangas")
            .navigationDestination(for: MangaModel.self, destination: { manga in
                Text(manga.title)
            })
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $vm.searchedText, prompt: "Search manga by name")
            .onChange(of: vm.searchedText) {
                timer?.invalidate()
                timer = .scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
                    Task {
                        await vm.resetMangas()
                        await vm.loadMangas()
                    }
                }

            }
        }
    }
}

#Preview {
    ContentView(vm: .preview)
}
