//
//  pokedataApp.swift
//  pokedata
//
//  Created by Camiilo on 20/01/24.
//

import SwiftUI

@main
struct pokedataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
