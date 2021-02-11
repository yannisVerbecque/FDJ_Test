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
    let alternateName: String
    let sport: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idLeague"
        case name = "strLeague"
        case alternateName = "strLeagueAlternate"
        case sport = "strSport"
    }
    
    func getNameLeagueForURL() -> String {
        if let urlString = self.alternateName.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            return urlString
        } else {
            return self.alternateName.replacingOccurrences(of: " ", with: "%20")
        }
    }
}
