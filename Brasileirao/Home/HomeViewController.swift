//
//  ViewController.swift
//  Brasileirao
//
//  Created by João Pedro Volponi on 27/10/24.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView()
    private let viewModel = TeamsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Brasileirão"
        view.backgroundColor = .white
        setupTableView()
        fetchData()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TeamCell.self, forCellReuseIdentifier: "TeamCell")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func fetchData() {
        viewModel.fetchTeams { [weak self] teams in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let teams = teams {
                    self.viewModel.teams = teams
                    self.tableView.reloadData()
                } else {
                    self.showErrorAlert()
                }
            }
        }
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Erro", message: "Não foi possível carregar os times.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell", for: indexPath) as? TeamCell else {
            return UITableViewCell()
        }
        let team = viewModel.teams[indexPath.row]
        cell.configure(with: team)
        return cell
    }
}
