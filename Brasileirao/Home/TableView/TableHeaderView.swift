//
//  TableHeaderView.swift
//  Brasileirao
//
//  Created by João Pedro Volponi on 06/11/24.
//

import UIKit

class TableHeaderView: UITableViewHeaderFooterView {
    
    lazy var teamNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Clube"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var pointsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "P"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var gamesPlayedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "J"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var winsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "V"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var drawLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "E"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var lossesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "D"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(teamNameLabel)
        addSubview(pointsLabel)
        addSubview(gamesPlayedLabel)
        addSubview(winsLabel)
        addSubview(drawLabel)
        addSubview(lossesLabel)
    }
    
    private func setupConstraints() {        
        NSLayoutConstraint.activate([
            lossesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            lossesLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            lossesLabel.widthAnchor.constraint(equalToConstant: 20),
            
            drawLabel.trailingAnchor.constraint(equalTo: lossesLabel.leadingAnchor, constant: -15),
            drawLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            drawLabel.widthAnchor.constraint(equalToConstant: 20),
            
            winsLabel.trailingAnchor.constraint(equalTo: drawLabel.leadingAnchor, constant: -15),
            winsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            winsLabel.widthAnchor.constraint(equalToConstant: 20),
            
            gamesPlayedLabel.trailingAnchor.constraint(equalTo: winsLabel.leadingAnchor, constant: -15),
            gamesPlayedLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            gamesPlayedLabel.widthAnchor.constraint(equalToConstant: 20),
            
            pointsLabel.trailingAnchor.constraint(equalTo: gamesPlayedLabel.leadingAnchor, constant: -15),
            pointsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            pointsLabel.widthAnchor.constraint(equalToConstant: 20),
            
            teamNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            teamNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
