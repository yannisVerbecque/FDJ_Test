//
//  League.swift
//  FDJ_Test
//
//  Created by Yannis VERBECQUE on 10/02/2021.
//

import Foundation

struct League: Decodable {
    let id: String
    let name: String
    let alternateName: String?
    let sport: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idLeague"
        case name = "strLeague"
        case alternateName = "strLeagueAlternate"
        case sport = "strSport"
    }
    
    // return true if name of league or alternate name contains text input
    func doesLeagueNameContain(name: String) -> Bool {
        if let safeName = self.alternateName {
            if safeName.lowercased().contains(name.lowercased()) {
                return true
            }
        }
        if self.name.lowercased().contains(name.lowercased()) {
            return true
        }
        return false
    }
}

struct LeagueRequest: Decodable {
    let leagues: [League]
    
    // return all matching league with name included
    func filterWithLeagueName(name: String) -> [League] {
        return leagues.filter({ $0.doesLeagueNameContain(name: name) })
    }
}
