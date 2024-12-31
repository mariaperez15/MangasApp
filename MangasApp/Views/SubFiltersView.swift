//
//  SubFiltersView.swift
//  MangasApp
//
//  Created by María Pérez  on 31/12/24.
//

import SwiftUI

struct SubFiltersView: View {
    @Environment(MangasVM.self) var vm
    
    var body: some View {
        List(vm.filterOptions, id: \.self) { filterOption in
            NavigationLink(value: filterOption) {
                Text(filterOption)
            }
        }
        .navigationTitle("Select filter")
        .navigationDestination(for: String.self) { filterOption in
            MangasListView()
                .task {
                    vm.setFilter(filter: nil, optionSelected: filterOption)
                }
        }
    }
}

#Preview {
    SubFiltersView()
        .environment(MangasVM.preview)
}
