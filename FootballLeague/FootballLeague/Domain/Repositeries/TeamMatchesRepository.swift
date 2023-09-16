//
//  TeamMatchesRepository.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 14/09/2023.
//

import Foundation
import CoreData

class TeamMatchesRepository: TeamMatchesDataRepository {
 
 
    private let networkService: NetworkService
    private let coreDataManager: CoreDataManager

    
    init(networkService: NetworkService, coreDataManager: CoreDataManager) {
        self.networkService = networkService
        self.coreDataManager = coreDataManager
    }
    
    
    //MARK: - Get leagues data from entity
    private func fetchCachedTeamsMatchesData(_ teamId: Int) throws -> Result<[TeamMatchesIModel], CachDataError> {
        let request = NSFetchRequest<TeamMatchesEntity>(entityName: "TeamMatchesEntity")
        do {
            request.predicate = NSPredicate(format: "teamId == %@", "\(teamId)")
            
            request.returnsObjectsAsFaults = false
            
            let cachedTeamMatches = try coreDataManager.managedObjectContext.fetch(request)
            print("cached data retrieved", cachedTeamMatches)
            
            return .success(cachedTeamMatches.map({TeamMatchesIModel($0)}).sorted(by:{$0.matchDate.convertStringToDate() < $1.matchDate.convertStringToDate()} ))

        } catch {
            return .failure(CachDataError.onReadError(error))
        }
      
    }

    //MARK: - Save new league Teams data
    func cacheTeamMatches(_ matches: TeamMatches?, teamId: Int) throws {
           try deleteAllTeams(teamId)
           print("save data to cache", matches?.matches ?? [])
           let context = coreDataManager.managedObjectContext
           let _ =  matches?.toEntity(in: context)
           
           do {
               try context.save()
           } catch {
               throw CachDataError.onSaveError(error)
           }
       }

    func deleteAllTeams(_ teamId: Int) throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "TeamMatchesEntity")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            fetchRequest.predicate = NSPredicate(format: "teamId == %@", "\(teamId)")
            
            fetchRequest.returnsObjectsAsFaults = false
            
            try coreDataManager.managedObjectContext.execute(batchDeleteRequest)
            try coreDataManager.managedObjectContext.save()
        } catch {
            throw CachDataError.onDeleteError(error)
        }
    }

    //MARK: - get teams response and return complition
    func getTeamMatches(_ teamId: Int) async throws -> ResultCallback<TeamMatchesResponse> {
        let endPoint = "teams/\(teamId)/matches"
        
        return try await networkService.performRequest(endPoint: endPoint, method: .get)
    }
    
    //MARK: - get cached leagues
    func getCachedTeamMatches(_ teamId: Int)  async throws -> Result<[TeamMatchesIModel], CachDataError> {
        return try self.fetchCachedTeamsMatchesData(teamId)
    }
    
    
}
