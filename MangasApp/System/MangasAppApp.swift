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
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(mangasVM)
        }
    }
}
