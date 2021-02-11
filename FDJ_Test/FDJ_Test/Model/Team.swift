//
//  Team.swift
//  FDJ_Test
//
//  Created by Yannis VERBECQUE on 10/02/2021.
//

import Foundation

struct Team: Decodable {
    let id: String
    let name: String
    let banner: String
    let country: String
    let league: String
    let badge: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idTeam"
        case name = "strTeam"
        case banner = "strTeamBanner"
        case country = "strCountry"
        case league = "strLeague"
        case badge = "strTeamBadge"
        case description = "strDescriptionEN"
    }
}

struct TeamRequest: Decodable {
    let teams: [Team]
}
