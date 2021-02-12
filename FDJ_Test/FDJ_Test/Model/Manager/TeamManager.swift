//
//  TeamManager.swift
//  FDJ_Test
//
//  Created by Yannis VERBECQUE on 11/02/2021.
//

import Foundation

class TeamManager {
    var teams: [Team] = [Team]()
    private var teamAPIEndpointString: String = "https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php"
    
    // Download post and decode them from JSON to instantiate League object
    func getTeamsByIDLeague(id: String, completion: @escaping (_ isCompleted: Bool) -> Void) {
        let requestURLString: String = teamAPIEndpointString.appending("?id=\(id)")
        
        do {
            
            try DownloadManager.downloadWithURL(requestURLString, completion: { [weak self] (data, response, error) in
                guard error == nil else {
                    completion(false)
                    return
                }
                
                guard let downloadedData = data else {
                    completion(false)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    // throws: `DecodingError.dataCorrupted` if cannot decode JSON
                    let teamRequest: TeamRequest = try decoder.decode(TeamRequest.self, from: downloadedData)
                    self?.teams = teamRequest.teams
                    completion(true)
                } catch DecodingError.keyNotFound(let key, let context) {
                    Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
                    completion(false)
                } catch DecodingError.valueNotFound(let type, let context) {
                    Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
                    completion(false)
                } catch DecodingError.typeMismatch(let type, let context) {
                    Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
                    completion(false)
                } catch DecodingError.dataCorrupted(let context) {
                    Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
                    completion(false)
                } catch let error as NSError {
                    NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
                    completion(false)
                }
            })
        } catch URLError.badURL {
            print("ContactManager badURL code \(URLError.badURL)")
            completion(false)
        } catch {
            print("Unknown Error \(error) \(error.localizedDescription)")
            completion(false)
        }
        
    }
}
