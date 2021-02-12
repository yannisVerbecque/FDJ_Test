//
//  ViewController.swift
//  FDJ_Test
//
//  Created by Yannis VERBECQUE on 10/02/2021.
//

import Foundation

protocol HomePageViewPresenter {
    func getLeagues()
    func selectedLeague(league: League)
    func showAutoComplete(setValue: Bool)
    func updateAutoCompleteViewable(view: AutoCompletionViewable)
    func gettingLeagueSearchText(text: String)
}

class HomePagePresenter: HomePageViewPresenter {
    func gettingLeagueSearchText(text: String) {
        var leaguesFiltered: [League] = self.leagueManager.leagues.filter({ $0.name.contains(text) })
        if (text.isEmpty || text.count == 0) {
            leaguesFiltered = self.leagueManager.leagues
        }
        self.autocompletionview?.showLeagues(leagues: leaguesFiltered)
    }
    
    
    func updateAutoCompleteViewable(view: AutoCompletionViewable) {
        self.autocompletionview = view
    }
    
    // Model
    var leagueManager = LeagueManager()
    // var teamManager = TeamManager()
    
    // Views
    unowned let homeview: HomeViewable
    unowned var autocompletionview: AutoCompletionViewable? = nil
    var selectedLeague: League?
    
    internal init(leagueManager: LeagueManager = LeagueManager(), view: HomeViewable) {
        self.leagueManager = leagueManager
        self.homeview = view
    }
    
    func getLeagues() {
        leagueManager.refreshLeagues { (didSucceed) in
        }
    }
    
    func selectedLeague(league: League) {
        self.selectedLeague = league
        print(self.selectedLeague)
    }
    
    func showAutoComplete(setValue: Bool) {
        if setValue {
            self.homeview.showAutoCompletion()
        } else {
            self.homeview.hideAutoCompletion()
        }
    }
}

