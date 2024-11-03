//
//  TableView.swift
//  Brasileirao
//
//  Created by João Pedro Volponi on 27/10/24.

import UIKit
import WebKit

class TeamCell: UITableViewCell {
    
    lazy var teamWebView: WKWebView = {
       let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    lazy var teamNameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var pointsLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(teamWebView)
        contentView.addSubview(teamNameLabel)
        contentView.addSubview(pointsLabel)
        
        NSLayoutConstraint.activate([
            teamWebView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            teamWebView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            teamWebView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1),
            teamWebView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1),
            
            teamWebView.widthAnchor.constraint(equalToConstant: 30),
            teamWebView.heightAnchor.constraint(equalToConstant: 30),

            teamNameLabel.leadingAnchor.constraint(equalTo: teamWebView.trailingAnchor, constant: 10),
            teamNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            pointsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            pointsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(with team: TeamResponse) {
        teamNameLabel.text = team.time.nomePopular
        pointsLabel.text = "Pontos: \(team.pontos)"
        
        if let url = URL(string: team.time.escudo) {
            let request = URLRequest(url: url)
            teamWebView.load(request)
        }
    }
}
