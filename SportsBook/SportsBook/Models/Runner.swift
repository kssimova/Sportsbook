//
//  Runner.swift
//  SportsBook
//
//  Created by Kristina Simova on 13.03.24.
//

import UIKit

enum Runner: Codable {
    case winDrawWin(WinDrawWinRunner)
    case totalGoalsInMatch(TotalGoalsInMatchRunner)
    
    init(from decoder: Decoder) throws {
        // Decode based on the market type
        let container = try decoder.singleValueContainer()
        if let winDrawWinRunner = try? container.decode(WinDrawWinRunner.self) {
            self = .winDrawWin(winDrawWinRunner)
        } else if let totalGoalsInMatchRunner = try? container.decode(TotalGoalsInMatchRunner.self) {
            self = .totalGoalsInMatch(totalGoalsInMatchRunner)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unable to decode RunnerType")
        }
    }
}

struct TotalGoalsInMatchRunner: Codable {
    let id: String
    let totalGoals: Int
    let odds: Odds
    let marketType: MarketType
}

struct WinDrawWinRunner: Codable {
    let id: String
    let name: String
    let odds: Odds
    let marketType: MarketType
}
