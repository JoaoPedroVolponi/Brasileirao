//
//  TableView.swift
//  Brasileirao
//
//  Created by João Pedro Volponi on 27/10/24.


import UIKit
import SwiftSVG

class TeamCell: UITableViewCell {
    private let teamImageView = UIImageView()
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
        teamImageView.contentMode = .scaleAspectFit
        teamImageView.translatesAutoresizingMaskIntoConstraints = false
        teamNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        teamNameLabel.translatesAutoresizingMaskIntoConstraints = false
        pointsLabel.font = UIFont.systemFont(ofSize: 14)
        pointsLabel.textColor = .gray
        pointsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(teamImageView)
        contentView.addSubview(teamNameLabel)
        contentView.addSubview(pointsLabel)
        
        NSLayoutConstraint.activate([
            teamImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            teamImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            teamImageView.widthAnchor.constraint(equalToConstant: 40),
            teamImageView.heightAnchor.constraint(equalToConstant: 40),
            
            teamNameLabel.leadingAnchor.constraint(equalTo: teamImageView.trailingAnchor, constant: 10),
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
            teamImageView.image = UIImage(named: "default") // Imagem padrão se a URL não for válida
            return
        }
        
        // Limpa a imagem anterior para evitar que a célula mostre uma imagem errada ao ser reutilizada
        teamImageView.image = nil

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Erro ao carregar imagem: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse,
               !(200...299).contains(httpResponse.statusCode) {
                print("Resposta da requisição: \(httpResponse.statusCode)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Dados da imagem inválidos ou não puderam ser decodificados.")
                return
            }
            
            DispatchQueue.main.async {
                self?.teamImageView.image = image
            }
        }.resume()
    }
}
