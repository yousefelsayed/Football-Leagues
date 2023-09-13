//
//  LeagueTeamsRepository.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 13/09/2023.
//

import Foundation
import CoreData

class LeagueTeamsRepository: LeagueTeamsDataRepository {
 
    private let networkService: NetworkService
    private let coreDataManager: CoreDataManager

    
    init(networkService: NetworkService, coreDataManager: CoreDataManager) {
        self.networkService = networkService
        self.coreDataManager = coreDataManager
    }
    
    
    //MARK: - Get leagues data from entity
    private func fetchCachedLeagueTeamsData(_ leagueCode: String) throws -> Result<[LeagueTeamsIModel], CachDataError> {
        let request = NSFetchRequest<LeagueTeamsEntity>(entityName: "LeagueTeamsEntity")
        do {
            request.predicate = NSPredicate(format: "leagueCode == %@", "\(leagueCode)")
            
            request.returnsObjectsAsFaults = false
            
            let cachedLeagues = try coreDataManager.managedObjectContext.fetch(request)
            print("cached data retrieved", cachedLeagues)

            return .success(cachedLeagues.map({LeagueTeamsIModel($0)}))

        } catch {
            return .failure(CachDataError.onReadError(error))
        }
      
    }

    //MARK: - Save new league Teams data
    func cacheLeagueTeamsData(_ teams: LeagueTeams?, leagueCode: String) throws {
        let context = coreDataManager.managedObjectContext

        // Fetch the existing league entity by leagueCode
        let fetchRequest: NSFetchRequest<LeagueTeamsEntity> = LeagueTeamsEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueCode == %@", leagueCode)

        if var existingLeagueEntity = try context.fetch(fetchRequest).first {
            // Update the existing league entity with new teams
            existingLeagueEntity = (teams?.toEntity(in: context))!
        } else {
            // Create a new league entity if it doesn't exist
            var leagueEntity = LeagueTeamsEntity(context: context)
            leagueEntity.leagueCode = leagueCode
            leagueEntity = (teams?.toEntity(in: context))!
        }

        do {
            try context.save()
        } catch {
            throw CachDataError.onSaveError(error)
        }
    }

    func deleteAllTeams(_ leagueCode: String) throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "LeagueTeamsEntity")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            fetchRequest.predicate = NSPredicate(format: "leagueCode == %@", "\(leagueCode)")
            
            fetchRequest.returnsObjectsAsFaults = false
            
            try coreDataManager.managedObjectContext.execute(batchDeleteRequest)
            try coreDataManager.managedObjectContext.save()
        } catch {
            throw CachDataError.onDeleteError(error)
        }
    }

    //MARK: - get teams response and return complition
    func getLeagueTeams(_ leagueCode: String) async throws -> ResultCallback<LeagueTeamsResponse> {
        let endPoint = "competitions/\(leagueCode)/teams"
        
        return try await networkService.performRequest(endPoint: endPoint, method: .get)
    }
    
    //MARK: - get cached leagues
    func getCachedLeagueTeams(_ leagueCode: String)  async throws -> Result<[LeagueTeamsIModel], CachDataError> {
        return try self.fetchCachedLeagueTeamsData(leagueCode)
    }
    
    
}
