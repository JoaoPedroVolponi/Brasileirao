//
//  HomeViewModel.swift
//  Brasileirao
//
//  Created by João Pedro Volponi on 27/10/24.
//

import Foundation
import UIKit

class HomeViewModel {
    var teams = [TeamResponse]()
    private let apiUrl = "https://api.api-futebol.com.br/v1/campeonatos/10/tabela"
    private let token = "live_e5e47ff78fc275d4160d15277ccebe"

    func fetchTeams(completion: @escaping ([TeamResponse]?) -> Void) {
        guard let url = URL(string: apiUrl) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            do {
                let decodedData = try JSONDecoder().decode([TeamResponse].self, from: data)
                completion(decodedData)
                print(decodedData)
            } catch {
                print("Erro ao decodificar JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}

