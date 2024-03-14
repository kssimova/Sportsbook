//
//  PrimaryMarket.swift
//  SportsBook
//
//  Created by Kristina Simova on 13.03.24.
//

import UIKit

struct PrimaryMarket: Codable {
    let type: MarketType
    var runners: [Runner]
    let id: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case type
        case runners
        case id
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(MarketType.self, forKey: .type)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
        var nestedContainer = try container.nestedUnkeyedContainer(forKey: .runners)
        runners = []
        
        // Decode runners based on market type
        switch type {
        case .WIN_DRAW_WIN, .MATCH_BETTING:
            while !nestedContainer.isAtEnd {
                if let runner = try? nestedContainer.decode(WinDrawWinRunner.self) {
                    runners.append(Runner.winDrawWin(runner))
                }
            }
        case .TOTAL_GOALS_IN_MATCH:
            while !nestedContainer.isAtEnd {
                if let runner = try? nestedContainer.decode(TotalGoalsInMatchRunner.self) {
                    runners.append(.totalGoalsInMatch(runner))
                }
            }
        }
    }
}
