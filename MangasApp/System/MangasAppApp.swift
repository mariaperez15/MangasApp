//
//  MangasAppApp.swift
//  MangasApp
//
//  Created by María Pérez  on 14/12/24.
//

import SwiftUI

@main
struct MangasAppApp: App {
    @State var mangasVM = MangasVM()
    @State var usersVM = LoginVM()
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
            // si el usuario ya esta logeado, muestro directamente el homeview, sino el loginView
            //HomeView()
            .environment(mangasVM)
            .environment(usersVM)
            .animation(.easeInOut, value: usersVM.isUserLogged)
        }
    }
}
