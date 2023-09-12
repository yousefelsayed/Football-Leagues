//
//  CoreDataManager.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 11/09/2023.
//

import Foundation
import CoreData

enum CachDataError: Error {
    case onSaveError(Error)
    case onReadError(Error)
    case onDeleteError(Error)
    case onError(String)
    
    var localizedDescription: String {
            switch self {
            case .onSaveError(let error),
                 .onReadError(let error),
                 .onDeleteError(let error):
                return error.localizedDescription
            case .onError(let message):
                return message
            }
        }
}

class CoreDataManager {
    static let shared = CoreDataManager() // Singleton instance

    private init() {} // Private init to ensure it's a singleton

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FootballLeague")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        let context = managedObjectContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
