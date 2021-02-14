//
//  DetailViewController.swift
//  FDJ_Test
//
//  Created by Yannis VERBECQUE on 10/02/2021.
//

import Foundation
import UIKit

protocol Viewable: class {
    func viewDidLoad()
    func loadView()
    func setConstraints()
}

protocol DetailViewable: Viewable {
    func setTeam(_ team: Team)
}

class DetailViewController: UIViewController, DetailViewable {
    
    // UI Elements
    var scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentOffset = .zero
        return scrollView
    }()
    
    var bannerImageView: UIImageView = {
        let imgView: UIImageView = UIImageView(frame: .zero)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
       return imgView
    }()
    
    var countryLabel: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var leagueLabel: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var descriptionTextView: UITextView = {
        let textView: UITextView = UITextView(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let margin: CGFloat = 8.0
    var presenter: DetailViewPresenter?
    
    // Set team information in the view
    func setTeam(_ team: Team) {
        title = team.name
        self.presenter?.setBanner(completion: { (data) in
            if let data = data {
                DispatchQueue.main.async {
                    self.bannerImageView.image = UIImage(data: data)
                }
            }
        })
        self.countryLabel.text = team.country
        self.leagueLabel.text = team.league
        self.descriptionTextView.text = team.description
    }
    
    // MARK: UI Work
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.bannerImageView)
        self.scrollView.addSubview(self.countryLabel)
        self.scrollView.addSubview(self.leagueLabel)
        self.scrollView.addSubview(self.descriptionTextView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getTeam()
        self.setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.bannerImageView.leadingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.leadingAnchor),
            self.bannerImageView.trailingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.trailingAnchor),
            self.bannerImageView.topAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.topAnchor),
            self.bannerImageView.heightAnchor.constraint(equalToConstant: 90),
            self.countryLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: self.margin),
            self.countryLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -self.margin),
            self.countryLabel.topAnchor.constraint(equalTo: self.bannerImageView.bottomAnchor, constant: self.margin),
            self.countryLabel.heightAnchor.constraint(equalToConstant: 20),
            self.leagueLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: self.margin),
            self.leagueLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -self.margin),
            self.leagueLabel.topAnchor.constraint(equalTo: self.countryLabel.bottomAnchor, constant: self.margin),
            self.leagueLabel.heightAnchor.constraint(equalToConstant: 20),
            self.descriptionTextView.topAnchor.constraint(equalTo: self.leagueLabel.bottomAnchor, constant: self.margin),
            self.descriptionTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: self.margin),
            self.descriptionTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -self.margin),
            self.descriptionTextView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
        ])
    }
    
}
