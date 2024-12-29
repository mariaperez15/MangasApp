//
//  FiltersView.swift
//  MangasApp
//
//  Created by María Pérez  on 29/12/24.
//

import SwiftUI

struct FiltersView: View {
    @State var vm = MangasVM()
    @State var filters: Filters = .all
    
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
                MangasListView(vm: vm)
                    .task {
                        vm.setFilter(filter: filter)
                    }
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    FiltersView()
}
