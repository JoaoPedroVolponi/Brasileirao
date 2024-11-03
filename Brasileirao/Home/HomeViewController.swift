//
//  ViewController.swift
//  Brasileirao
//
//  Created by João Pedro Volponi on 27/10/24.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var tableView: UITableView!
    private var viewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchTeams()
    }

    private func setupTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TeamCell.self, forCellReuseIdentifier: "TeamCell")
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
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


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.teams.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell", for: indexPath) as! TeamCell
        let team = viewModel.teams[indexPath.row]
        cell.configure(with: team)
        return cell
    }
}
