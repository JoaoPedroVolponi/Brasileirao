//
//  TableView.swift
//  Brasileirao
//
//  Created by João Pedro Volponi on 27/10/24.

import UIKit
import WebKit

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
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(teamImageView)
        contentView.addSubview(teamNameLabel)
        contentView.addSubview(pointsLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            teamImageView.widthAnchor.constraint(equalToConstant: 30),
            teamImageView.heightAnchor.constraint(equalToConstant: 30),
            teamImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            teamImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            teamNameLabel.leadingAnchor.constraint(equalTo: teamImageView.trailingAnchor, constant: 10),
            teamNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            pointsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            pointsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(with teamName: String, logoURL: String, indexPath: IndexPath) {
        teamNameLabel.text = teamName
        currentIndexPath = indexPath
        loadSVG(from: logoURL)
    }
    
    private func loadSVG(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        teamImageView.sd_setImage(with: url, placeholderImage: nil, options: .highPriority, context: [.imageThumbnailPixelSize: CGSize(width: 30, height: 30)])
    }
}
