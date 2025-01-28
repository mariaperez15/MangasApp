//
//  AddMangaSheetView.swift
//  MangasApp
//
//  Created by María Pérez  on 28/1/25.
//

import SwiftUI

struct AddMangaSheetView: View {
    @Environment(CollectionVM.self) var vm
    
    var body: some View {
        //Hacer vista con botones que rellenen los campos del vm de collecion con el $ para que esten vinculados
        
        Button {
            Task {
               await vm.addMangaToCollection()
            }
        } label: {
            Text("Añadir manga a la colección")
            //una vez añadido poner texto de quitar de la colección, es decir hacer un toggle con una propiedad bool que diga si esta o no en la colección)
        }

    }
}

#Preview {
    AddMangaSheetView()
        .environment(CollectionVM.init())
}
