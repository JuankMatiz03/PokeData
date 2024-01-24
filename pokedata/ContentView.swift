//
//  ContentView.swift
//  pokedata
//
//  Created by Camiilo on 20/01/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        Text("PokeData")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, CoreDataManager.shared.persistentContainer.viewContext)
    }
}
