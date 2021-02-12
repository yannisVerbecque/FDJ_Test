//
//  HomePageViewController.swift
//  FDJ_Test
//
//  Created by Yannis VERBECQUE on 11/02/2021.
//

import Foundation
import UIKit

protocol HomeViewable: Viewable {
    func showAutoCompletion()
    func hideAutoCompletion()
    func resignSearchBarFirstResponder()
    func showTeams(teams: [Team])
}

class HomePageViewController: UIViewController {
    
    var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.searchBarStyle = .default
        return bar
    }()
    
    static let reuseIdentifier: String = "collectionViewCell"
    var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionViewLayout.itemSize = CGSize(width: 165, height: 165)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(TeamCollectionViewCell.self, forCellWithReuseIdentifier: HomePageViewController.reuseIdentifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var teams: [Team] = [Team]()
    
    var autoCompletionView: AutoCompletionResultViewController = {
       let autoCompletion = AutoCompletionResultViewController()
        autoCompletion.view.translatesAutoresizingMaskIntoConstraints = false
        autoCompletion.view.backgroundColor = .red
        autoCompletion.view.isHidden = true
        return autoCompletion
    }()
    
    var presenter: HomePagePresenter?
    
    
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = .white
        title = "Teams"
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = .white
        self.view.addSubview(self.collectionView)
        
        self.searchBar.placeholder = "Search for a league"
        self.searchBar.delegate = self
        self.view.addSubview(self.searchBar)
        
        self.autoCompletionView.view.translatesAutoresizingMaskIntoConstraints = false
        self.presenter?.updateAutoCompleteViewable(view: self.autoCompletionView)
        self.view.addSubview(self.autoCompletionView.view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setConstraints()
        presenter?.getLeagues()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            self.searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.searchBar.heightAnchor.constraint(equalToConstant: 45),
            self.collectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.autoCompletionView.view.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            self.autoCompletionView.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.autoCompletionView.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.autoCompletionView.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
}

extension HomePageViewController: HomeViewable {
    
    func showTeams(teams: [Team]) {
        self.teams = teams
        self.collectionView.reloadData()
        print(teams)
    }
    
    func showAutoCompletion() {
        self.autoCompletionView.view.isHidden = false
    }
    
    func hideAutoCompletion() {
        self.autoCompletionView.view.isHidden = true
    }
    
    func resignSearchBarFirstResponder() {
        self.searchBar.resignFirstResponder()
    }
    
}

extension HomePageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let team: Team = self.presenter?.getTeamAtIndex(indexPath: indexPath) {
            let detailVC = DetailViewController()
            let detailPresenter = DetailPresenter(view: detailVC, team: team)
            detailVC.presenter = detailPresenter
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension HomePageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.teams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePageViewController.reuseIdentifier, for: indexPath) as! TeamCollectionViewCell
        self.presenter?.getDataForTeamBadge(indexPath: indexPath, completion: { (data) in
            if let data = data {
                DispatchQueue.main.async {
                    cell.imageView.image = UIImage(data: data)
                }
            }
        })
        return cell
    }
    
}

extension HomePageViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.presenter?.showAutoComplete(setValue: true)
        self.presenter?.gettingLeagueSearchText(text: searchBar.searchTextField.text ?? "")
        searchBar.setShowsCancelButton(!searchBar.showsCancelButton, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
        searchBar.setShowsCancelButton(!searchBar.showsCancelButton, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.presenter?.showAutoComplete(setValue: false)
        searchBar.searchTextField.resignFirstResponder()
        searchBar.setShowsCancelButton(!searchBar.showsCancelButton, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter?.gettingLeagueSearchText(text: searchText)
    }
    
}
