//
//  CoreDataManager.swift
//  pokedata
//
//  Created by Camiilo on 21/01/24.
//

import CoreData

/// Clase singleton encargada de gestionar las operaciones de Core Data
class CoreDataManager {
    
    /// Instancia para el coreDta
    static let shared = CoreDataManager()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Pokepersist")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Error loading Core Data stores: \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    /// Guarda los cambios en el contexto de objetos gestionados
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Error no resuelto \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
