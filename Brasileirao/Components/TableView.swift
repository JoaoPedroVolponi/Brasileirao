//
//  TableView.swift
//  Brasileirao
//
//  Created by João Pedro Volponi on 27/10/24.


import UIKit
import SwiftSVG

class TeamCell: UITableViewCell {
    private let teamSVGView = UIView()
    private let teamNameLabel = UILabel()
    private let pointsLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        teamSVGView.contentMode = .scaleAspectFit
        teamSVGView.translatesAutoresizingMaskIntoConstraints = false
        teamNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        teamNameLabel.translatesAutoresizingMaskIntoConstraints = false
        pointsLabel.font = UIFont.systemFont(ofSize: 14)
        pointsLabel.textColor = .gray
        pointsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(teamSVGView)
        contentView.addSubview(teamNameLabel)
        contentView.addSubview(pointsLabel)
        
        NSLayoutConstraint.activate([
            teamSVGView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            teamSVGView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            teamSVGView.widthAnchor.constraint(equalToConstant: 40),
            teamSVGView.heightAnchor.constraint(equalToConstant: 40),
            
            teamNameLabel.leadingAnchor.constraint(equalTo: teamSVGView.trailingAnchor, constant: 10),
            teamNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            pointsLabel.leadingAnchor.constraint(equalTo: teamNameLabel.leadingAnchor),
            pointsLabel.topAnchor.constraint(equalTo: teamNameLabel.bottomAnchor, constant: 5),
            pointsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with team: TeamResponse) {
        teamNameLabel.text = team.time.nomePopular
        pointsLabel.text = "Posição: \(team.posicao) - Pontos: \(team.pontos)"
        
        guard let url = URL(string: team.time.escudo) else {
            return
        }

        teamSVGView.subviews.forEach { $0.removeFromSuperview() }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil else {
                print("Erro ao carregar SVG: \(String(describing: error))")
                return
            }
            
            DispatchQueue.main.async {
                let svgView = UIView(SVGData: data) { image in
                    image.resizeToFit(self.teamSVGView.bounds)
                }
                svgView.frame = self.teamSVGView.bounds
                svgView.contentMode = .scaleAspectFit
                self.teamSVGView.addSubview(svgView)
            }
        }.resume()
    }
}
