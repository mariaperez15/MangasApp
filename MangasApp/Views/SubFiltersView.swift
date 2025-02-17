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
        ScrollView {
            LazyVStack (spacing: 16) {
                ForEach(vm.filterOptions, id: \.self) { filterOption in
                    NavigationLink(value: filterOption) {
                        subFilterCard(filterOption: filterOption)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(vm.currentFilter.description)
        .background(
            Color(.systemBackground)
                .ignoresSafeArea()
        )
        .navigationDestination(for: String.self) { filterOption in
            MangasListView()
                .task {
                    vm.setFilter(filter: nil, optionSelected: filterOption)
                }
        }
    }
    
    struct subFilterCard: View {
        let filterOption: String
        
        var body: some View{
            HStack {
                Text(filterOption)
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 8)
                    .fontWeight(.semibold)
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.white.opacity(0.9))
                    .padding(.trailing)
                    .fontWeight(.semibold)
            }
            .padding(.horizontal, 20)
            .frame(height: 65)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color: .blue.opacity(0.2), radius: 8, x: 0, y: 4)
        }
    }
}


#Preview {
    SubFiltersView()
        .environment(MangasVM.preview)
}
