//
//  ViewController.swift
//  Brasileirao
//
//  Created by João Pedro Volponi on 27/10/24.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var viewModel: HomeViewModel!
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TeamCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupConstraints()
        fetchTeams()
    }

    private func setupTableView() {
        view.addSubview(tableView)
    }

    func fetchTeams() {
        viewModel = HomeViewModel()
        viewModel.fetchTeams { [weak self] teams in
            guard let self = self, let teams = teams else { return }
            DispatchQueue.main.async {
                self.viewModel.teams = teams
                self.tableView.reloadData()
            }
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell", for: indexPath) as! TableViewCell
        let teamResponse = viewModel.teams[indexPath.row]
        cell.configure(with: teamResponse.time.nome, logoURL: teamResponse.time.escudo, indexPath: indexPath)
        return cell
    }
}
