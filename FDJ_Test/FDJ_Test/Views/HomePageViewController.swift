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
}

class HomePageViewController: UIViewController, HomeViewable {
    
    var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.searchBarStyle = .default
        return bar
    }()
    
    var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var autoCompletionView: AutoCompletionResultViewController = {
       let autoCompletion = AutoCompletionResultViewController()
        autoCompletion.view.translatesAutoresizingMaskIntoConstraints = false
        autoCompletion.view.backgroundColor = .red
        autoCompletion.view.isHidden = true
        return autoCompletion
    }()
    
    var presenter: HomePagePresenter?
    
    func showAutoCompletion() {
        self.autoCompletionView.view.isHidden = false
    }
    
    func hideAutoCompletion() {
        self.autoCompletionView.view.isHidden = true
    }
    
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
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
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

extension HomePageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension HomePageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
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

extension HomePageViewController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
    }
    func didDismissSearchController(_ searchController: UISearchController) {
    }
}
