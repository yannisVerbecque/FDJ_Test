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
    
}

struct LeagueRequest: Decodable {
    let leagues: [League]
}
