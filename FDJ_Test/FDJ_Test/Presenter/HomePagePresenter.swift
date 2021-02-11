//
//  ViewController.swift
//  FDJ_Test
//
//  Created by Yannis VERBECQUE on 10/02/2021.
//

import Foundation

protocol HomePageViewPresenter {
    func getLeagues()
    
}

class HomePagePresenter: HomePageViewPresenter {
    
    func getLeagues() {
        leagueManager.refreshLeagues { (didSucceed) in
            print(self.leagueManager.leagues)
        }
    }
    
    var leagueManager = LeagueManager()
    unowned let view: HomeViewable
    
    internal init(leagueManager: LeagueManager = LeagueManager(), view: HomeViewable) {
        self.leagueManager = leagueManager
        self.view = view
    }
}

