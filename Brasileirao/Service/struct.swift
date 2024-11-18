//
//  struct.swift
//  Brasileirao
//
//  Created by João Pedro Volponi on 27/10/24.
//

struct TeamResponse: Decodable {
    let posicao: Int
    let pontos: Int
    let time: Team
    let jogos: Int
    let vitorias: Int
    let empates: Int
    let derrotas: Int
    let golsPro: Int
    let golsContra: Int
    let saldoGols: Int
    let aproveitamento: Int
    let ultimosJogos: [String]

    enum CodingKeys: String, CodingKey {
        case posicao, pontos, time, jogos, vitorias, empates, derrotas, ultimosJogos = "ultimos_jogos"
        case golsPro = "gols_pro"
        case golsContra = "gols_contra"
        case saldoGols = "saldo_gols"
        case aproveitamento
    }
}

struct Team: Decodable {
    let timeId: Int
    let nome: String
    let sigla: String
    let escudo: String

    enum CodingKeys: String, CodingKey {
        case timeId = "time_id"
        case nome = "nome_popular"
        case sigla, escudo
    }
}
