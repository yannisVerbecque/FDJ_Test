//
//  AutoCompletionResultViewController.swift
//  FDJ_Test
//
//  Created by Yannis VERBECQUE on 11/02/2021.
//

import Foundation
import UIKit

protocol AutoCompletionViewable: Viewable {
    func showLeagues(leagues: [League])
    func updatePresenter(presenter: HomePagePresenter)
}

class AutoCompletionResultViewController: UIViewController, AutoCompletionViewable {
    func updatePresenter(presenter: HomePagePresenter) {
        self.presenter = presenter
    }
    

    lazy var tableview: UITableView = {
        let tableview = UITableView(frame: .zero)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    var presenter: HomePagePresenter?
    let reuseIdentifier: String = "AutoCompletionCell"
    var filteredLeagues: [League] = []
    
    override func loadView() {
        super.loadView()
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.view.addSubview(self.tableview)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            self.tableview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableview.topAnchor.constraint(equalTo: self.view.topAnchor)
        ])
    }
    
    func showLeagues(leagues: [League]) {
        self.filteredLeagues = leagues
        self.tableview.reloadData()
    }
    
}

extension AutoCompletionResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredLeagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: self.reuseIdentifier)
        cell.textLabel?.text = self.filteredLeagues[indexPath.row].name
        cell.detailTextLabel?.text = self.filteredLeagues[indexPath.row].alternateName
        return cell
    }
}

extension AutoCompletionResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectedLeague(league: self.filteredLeagues[indexPath.row])
    }
}
