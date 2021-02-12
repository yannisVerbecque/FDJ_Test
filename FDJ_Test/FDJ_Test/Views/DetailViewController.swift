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
        textView.isScrollEnabled = false
        return textView
    }()
    
    let margin: CGFloat = 8.0
    var presenter: DetailViewPresenter?
    
    func setTeam(_ team: Team) {
        title = team.name
        self.bannerImageView.image = UIImage.init(named: team.banner ?? "")
        self.countryLabel.text = team.country
        self.leagueLabel.text = team.league
        self.descriptionTextView.text = team.description
    }
    
    // MARK: UI Work
    override func loadView() {
        super.loadView()
        
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.bannerImageView)
        self.scrollView.addSubview(self.countryLabel)
        self.scrollView.addSubview(self.leagueLabel)
        self.scrollView.addSubview(self.descriptionTextView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.bannerImageView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.bannerImageView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.bannerImageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.bannerImageView.heightAnchor.constraint(equalToConstant: 30),
            self.countryLabel.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: self.margin),
            self.countryLabel.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: -self.margin),
            self.countryLabel.topAnchor.constraint(equalTo: self.bannerImageView.bottomAnchor, constant: self.margin),
            self.countryLabel.heightAnchor.constraint(equalToConstant: 20),
            self.leagueLabel.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: self.margin),
            self.leagueLabel.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: -self.margin),
            self.leagueLabel.topAnchor.constraint(equalTo: self.countryLabel.bottomAnchor, constant: self.margin),
            self.leagueLabel.heightAnchor.constraint(equalToConstant: 20),
            self.descriptionTextView.topAnchor.constraint(equalTo: self.leagueLabel.bottomAnchor, constant: self.margin),
            self.descriptionTextView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: self.margin),
            self.descriptionTextView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -self.margin),
            self.descriptionTextView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
        ])
    }
    
}
