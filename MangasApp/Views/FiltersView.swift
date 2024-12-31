//
//  FiltersView.swift
//  MangasApp
//
//  Created by María Pérez  on 29/12/24.
//

import SwiftUI

struct FiltersView: View {
    @Environment(MangasVM.self) var vm
    
    var body: some View {
        NavigationStack {
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
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: MangaModel.self) { manga in
                MangaDetailComponent(manga: manga)
            }
            .navigationDestination(for: Filters.self) { filter in
                switch filter {
                case .all:
                    MangasListView()
                        .task {
                            vm.setFilter(filter: filter, optionSelected: nil)
                        }
                case .genre, .theme, .demographic:
                    SubFiltersView()
                        .task {
                            await vm.loadFilterOptions(filter: filter)
                        }
                case .bestMangas:
                    MangasListView()
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
