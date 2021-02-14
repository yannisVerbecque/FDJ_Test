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
    func getDataForTeamBadge(indexPath: IndexPath, completion: @escaping (Data?) -> Void)
    func getTeamAtIndex(indexPath: IndexPath) -> Team
}

class HomePagePresenter: HomePageViewPresenter {
    
    // Model
    var leagueManager = LeagueManager()
    var teamManager = TeamManager()
    
    // Views
    unowned let homeview: HomeViewable
    unowned var autocompletionview: AutoCompletionViewable? = nil
    var selectedLeague: League?
    
    internal init(leagueManager: LeagueManager = LeagueManager(), view: HomeViewable) {
        self.leagueManager = leagueManager
        self.homeview = view
    }
    
    // Get the team at index
    func getTeamAtIndex(indexPath: IndexPath) -> Team {
        return self.teamManager.teams[indexPath.row]
    }
    
    // Get the data asynchronously to be ready to use by uiimage in the view
    func getDataForTeamBadge(indexPath: IndexPath, completion: @escaping (Data?) -> Void) {
        let badgeString = self.teamManager.teams[indexPath.row].badge
        DispatchQueue.global().async {
            if let url = URL(string: badgeString), let data = try? Data(contentsOf: url) {
                completion(data)
            }
        }

    }
    
    // Filter League by name and show them to auto completion view
    func gettingLeagueSearchText(text: String) {
        var leaguesFiltered: [League] = self.leagueManager.leagues.filter({ $0.name.contains(text) })
        if (text.isEmpty || text.count == 0) {
            leaguesFiltered = self.leagueManager.leagues
        }
        self.autocompletionview?.showLeagues(leagues: leaguesFiltered)
    }
    
    
    func updateAutoCompleteViewable(view: AutoCompletionViewable) {
        self.autocompletionview = view
        self.autocompletionview?.updatePresenter(presenter: self)
    }

    // Download leagues for later use in league auto completion
    func getLeagues() {
        leagueManager.refreshLeagues { (didSucceed) in
        }
    }
    
    // Select a league, download the teams, display them in collection view
    func selectedLeague(league: League) {
        self.selectedLeague = league
        teamManager.getTeamsByIDLeague(id: league.id) { (didSucceed) in
            if didSucceed {
                DispatchQueue.main.async {
                    self.homeview.showTeams(teams: self.teamManager.teams)
                }
            } else {
                DispatchQueue.main.async {
                    self.homeview.showTeams(teams: [])
                }
            }
        }
    }
    
    // Decide if should show/hide auto completion view
    func showAutoComplete(setValue: Bool) {
        if setValue {
            self.homeview.showAutoCompletion()
        } else {
            self.homeview.hideAutoCompletion()
        }
    }
    
}

