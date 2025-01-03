//
//  FiltersView.swift
//  MangasApp
//
//  Created by María Pérez  on 29/12/24.
//

import SwiftUI

struct FiltersView: View {
    @Environment(MangasVM.self) var vm
    @State private var timer: Timer?
    
    var body: some View {
        @Bindable var bvm = vm
        NavigationStack {
            VStack {
                if vm.searchedText.isEmpty {
                    List(Filters.allCases) { filter in
                        NavigationLink(value: filter) {
                            VStack(alignment: .leading) {
                                Text(filter.rawValue)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                Text(filter.description)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 9)
                        }
                    }
                } else {
                    MangaListComponent()
                }
            }
            
            .navigationTitle(vm.currentFilter.rawValue)
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
            .navigationDestination(for: MangaModel.self) { manga in
                MangaDetailComponent(manga: manga)
            }
            .navigationDestination(for: Filters.self) { filter in
                switch filter {
                case .all, .bestMangas:
                    MangasListView()
                        .task {
                            vm.setFilter(filter: filter, optionSelected: nil)
                        }
                case .genre, .theme, .demographic:
                    SubFiltersView()
                        .task {
                            await vm.loadFilterOptions(filter: filter)
                        }
                }
            }
            .listStyle(.plain)
        }
    }
}


#Preview {
    FiltersView()
        .environment(MangasVM.preview)
}
