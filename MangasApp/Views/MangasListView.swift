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
        @Bindable var bvm = vm
        MangaListComponent()
            .navigationTitle(vm.currentFilter.description == "Show all mangas" || vm.currentFilter.description == "Show best mangas" ? vm.currentFilter.rawValue : vm.selectedSubfilter)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MangasListView()
        .environment(MangasVM.preview)
}
