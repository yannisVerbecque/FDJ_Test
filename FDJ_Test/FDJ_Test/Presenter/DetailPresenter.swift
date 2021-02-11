//
//  DetailPresenter.swift
//  FDJ_Test
//
//  Created by Yannis VERBECQUE on 10/02/2021.
//

import Foundation

protocol DetailViewPresenter {
    init(view: DetailViewable, team: Team)
    func getTeam()
}

class DetailPresenter: DetailViewPresenter {
    unowned let view: DetailViewable
    let team: Team
    
    func getTeam() {
        self.view.setTeam(self.team)
    }
    
    required init(view: DetailViewable, team: Team) {
        self.view = view
        self.team = team
    }
    
    
}
