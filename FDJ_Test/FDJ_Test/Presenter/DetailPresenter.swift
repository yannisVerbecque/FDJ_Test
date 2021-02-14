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
    func setBanner(completion: @escaping (Data?) -> Void)
}

class DetailPresenter: DetailViewPresenter {
    
    unowned let view: DetailViewable
    let team: Team
    
    // Fill detail view with a team
    func getTeam() {
        self.view.setTeam(self.team)
    }
    
    required init(view: DetailViewable, team: Team) {
        self.view = view
        self.team = team
    }
    
    // Download asynchronously the data for the uiimage in the detail view to display
    func setBanner(completion: @escaping (Data?) -> Void) {
        if let bannerString = self.team.banner {
            DispatchQueue.global().async {
                if let url = URL(string: bannerString), let data = try? Data(contentsOf: url) {
                    completion(data)
                }
            }
        }
    }

}
