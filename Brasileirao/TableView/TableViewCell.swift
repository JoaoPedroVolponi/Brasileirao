//
//  TableView.swift
//  Brasileirao
//
//  Created by João Pedro Volponi on 27/10/24.

import UIKit

class TableViewCell: UITableViewCell {
    
    private var currentIndexPath: IndexPath?
    
    lazy var teamImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var teamNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    lazy var pointsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var gamesPlayedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var winsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var drawLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var lossesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(positionLabel)
        contentView.addSubview(teamImageView)
        contentView.addSubview(teamNameLabel)
        contentView.addSubview(pointsLabel)
        contentView.addSubview(gamesPlayedLabel)
        contentView.addSubview(winsLabel)
        contentView.addSubview(drawLabel)
        contentView.addSubview(lossesLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            lossesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            lossesLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            lossesLabel.widthAnchor.constraint(equalToConstant: 20),
            
            drawLabel.trailingAnchor.constraint(equalTo: lossesLabel.leadingAnchor, constant: -15),
            drawLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            drawLabel.widthAnchor.constraint(equalToConstant: 20),
            
            winsLabel.trailingAnchor.constraint(equalTo: drawLabel.leadingAnchor, constant: -15),
            winsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            winsLabel.widthAnchor.constraint(equalToConstant: 20),
            
            pointsLabel.trailingAnchor.constraint(equalTo: winsLabel.leadingAnchor, constant: -15),
            pointsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            pointsLabel.widthAnchor.constraint(equalToConstant: 20),
            
            gamesPlayedLabel.trailingAnchor.constraint(equalTo: pointsLabel.leadingAnchor, constant: -15),
            gamesPlayedLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            gamesPlayedLabel.widthAnchor.constraint(equalToConstant: 20),
            
            positionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            positionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            teamImageView.widthAnchor.constraint(equalToConstant: 30),
            teamImageView.heightAnchor.constraint(equalToConstant: 30),
            teamImageView.leadingAnchor.constraint(equalTo: positionLabel.leadingAnchor, constant: 15),
            teamImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            teamNameLabel.leadingAnchor.constraint(equalTo: teamImageView.trailingAnchor, constant: 10),
            teamNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }

    func configure(with team: Brasileirao.TeamResponse, indexPath: IndexPath) {
        loadSVG(from: team.time.escudo)
        positionLabel.text = "\(team.posicao)"
        teamNameLabel.text = team.time.nome
        pointsLabel.text = "\(team.pontos)"
        gamesPlayedLabel.text = "\(team.jogos)"
        winsLabel.text = "\(team.vitorias)"
        drawLabel.text = "\(team.empates)"
        lossesLabel.text = "\(team.derrotas)"
        currentIndexPath = indexPath
    }
    
    private func loadSVG(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        teamImageView.sd_setImage(with: url, placeholderImage: nil, options: .highPriority, context: [.imageThumbnailPixelSize: CGSize(width: 30, height: 30)])
    }
}
