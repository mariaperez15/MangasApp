//
//  ContentView.swift
//  MangasApp
//
//  Created by María Pérez  on 14/12/24.
//

import SwiftUI

struct MangasListView: View {
    @Environment(MangasVM.self) var vm
    @State private var timer: Timer?
    
    var body: some View {
        @Bindable var bvm = vm //para cuando el viewmodel se pasa como enviroment
        MangaListComponent()
        /*.task {
            if vm.mangas.isEmpty {
                await vm.loadMangas()
            }
        }
         */
            .navigationTitle(vm.currentFilter.description == "Show all mangas" || vm.currentFilter.description == "Show best mangas" ? vm.currentFilter.rawValue : vm.selectedSubfilter)
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $bvm.searchedText, prompt: "Search manga by name")
        .onChange(of: vm.searchedText) {
            timer?.invalidate()
            timer = .scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                Task {
                    await vm.resetMangas()
                    await vm.loadMangas()
                }
            }
        }
    }
}

#Preview {
    MangasListView()
        .environment(MangasVM.preview)
}
