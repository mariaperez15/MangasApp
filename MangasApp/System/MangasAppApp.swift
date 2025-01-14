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
    @State var usersVM = UsersVM()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(mangasVM)
                .environment(usersVM)
        }
    }
}
