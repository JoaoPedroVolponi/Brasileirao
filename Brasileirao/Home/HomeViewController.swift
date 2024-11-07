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
        tableView.register(TableHeaderView.self, forHeaderFooterViewReuseIdentifier: "TableHeaderView")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Brasileirão"
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

    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell", for: indexPath) as! TableViewCell
        let teamResponse = viewModel.teams[indexPath.row]
        cell.configure(with: teamResponse, indexPath: indexPath)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableHeaderView") as? TableHeaderView
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
