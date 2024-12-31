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
            LazyVStack (spacing: 12) {
                ForEach(vm.filterOptions, id: \.self) { filterOption in
                    NavigationLink(value: filterOption) {
                        HStack {
                            Text(filterOption)
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                                .padding(.trailing)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 70)
                        .background(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.6, green: 0.8, blue: 0.95),
                                    Color(red: 0.7, green: 0.85, blue: 1.0)
                                    
                                ],
                                startPoint: .leading,
                                endPoint: .trailing)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(color: .blue.opacity(0.15), radius: 5, x: 0, y: 2)
                        
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
        .navigationTitle(vm.currentFilter.description)
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
