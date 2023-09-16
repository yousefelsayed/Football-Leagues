//
//  MockCoreDataManager.swift
//  FootballLeagueTests
//
//  Created by Yousef Elsayed on 16/09/2023.
//

import Foundation
import CoreData
@testable import FootballLeague

class MockCoreDataManager: CoreDataManagerProtocol {
    var saveContextCalled = false
    
    var managedObjectContext: NSManagedObjectContext {
        // Return a mock NSManagedObjectContext if needed
        return NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    }

    func saveContext() {
        saveContextCalled = true
    }
}
