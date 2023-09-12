//
//  LeaguesRepository.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 10/09/2023.
//

import Foundation
import CoreData


class LeaguesRepository: LeaguesDataRepository {
    
    private let networkService: NetworkService
    private let coreDataManager: CoreDataManager

    
    init(networkService: NetworkService, coreDataManager: CoreDataManager) {
        self.networkService = networkService
        self.coreDataManager = coreDataManager
    }
    
    //MARK: - get leagues response and return complition
    func getLeagues() async throws -> ResultCallback<LeaguesResponse> {
        let endPoint = "competitions"
        
        return try await networkService.performRequest(endPoint: endPoint, method: .get)
    }
    
    //MARK: - get cached leagues
    func getCachedLeagues() async throws -> Result<[League], CachDataError> {
        return try self.fetchCachedLeaguesData()
    }
    
    
    //MARK: - Get leagues data from entity
    private func fetchCachedLeaguesData() throws -> Result<[League], CachDataError> {
        let request = NSFetchRequest<LeaguesEntity>(entityName: "LeaguesEntity")
        do {
            let cachedLeagues = try coreDataManager.managedObjectContext.fetch(request)
            print("cached data retrieved", cachedLeagues)

            return .success(cachedLeagues.map({League($0)})
)
        } catch {
            return .failure(CachDataError.onReadError(error))
        }
      
    }

    //MARK: - Save new leagues data
    func cacheLeaguesData(_ leagues: Leagues?) throws {
        try deleteAllLeagues()
        print("save data to cache", leagues?.leagues ?? [])
        let context = coreDataManager.managedObjectContext
        let _ =  leagues?.toEntity(in: context)
        
        do {
            try context.save()
        } catch {
            throw CachDataError.onSaveError(error)
        }
    }

    func deleteAllLeagues() throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "LeaguesEntity")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coreDataManager.managedObjectContext.execute(batchDeleteRequest)
            try coreDataManager.managedObjectContext.save()
        } catch {
            throw CachDataError.onDeleteError(error)
        }
    }

}
