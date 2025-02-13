//
//  MangasAppApp.swift
//  MangasApp
//
//  Created by María Pérez  on 14/12/24.
//

import SwiftUI

@main
struct MangasApp: App {
    @State var mangasVM = MangasVM()
    @State var usersVM = LoginVM()
    @State var collectionVM = CollectionVM()
    var num = 2
    
    var body: some Scene {
        WindowGroup {
            Group {
                if usersVM.isUserLogged {
                    HomeView()
                } else {
                    LoginView()
                }
            }
            .environment(mangasVM)
            .environment(usersVM)
            .environment(collectionVM)
            .animation(.easeInOut, value: usersVM.isUserLogged)
        }
    }
}
