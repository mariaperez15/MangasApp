//
//  AddMangaSheetView.swift
//  MangasApp
//
//  Created by María Pérez  on 28/1/25.
//

import SwiftUI

struct AddMangaSheetView: View {
    @Environment(CollectionVM.self) var vm
    let mangaId: Int 
    
    var body: some View {
        @Bindable var bvm = vm
        //Hacer vista con botones que rellenen los campos del vm de collecion con el $ para que esten vinculados
        
        
        VStack{
            Toggle("Colección completa", isOn: $bvm.completeCollection)
                .toggleStyle(.switch)
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Volumes:")
                LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 5), spacing: 10) {
                    ForEach(1...20, id: \.self) { volume in
                        Button {
                            bvm.volumesOwned.append(volume)
                        } label: {
                            Text("\(volume)")
                                .frame(width: 40, height: 40)
                                .background(bvm.volumesOwned.contains(volume) ? Color.blue : Color.gray.opacity(0.3))
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        }
                    }
                }
            }
            .padding()
            
            Button {
                Task {
                    await vm.addMangaToCollection()
                }
            } label: {
                Text("Añadir manga a la colección")
                //TODO: una vez añadido poner texto de quitar de la colección, es decir hacer un toggle con una propiedad bool que diga si esta o no en la colección)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                
            }
            .padding(.top)
        }
        .onAppear() {
            bvm.manga = mangaId
        }
        
    }
}

#Preview {
    AddMangaSheetView(mangaId: 2)
        .environment(CollectionVM.init())
}
