//
//  MarketType.swift
//  SportsBook
//
//  Created by Kristina Simova on 13.03.24.
//

import Foundation

// MarketType enum
enum MarketType: String, Codable {
    case WIN_DRAW_WIN
    case MATCH_BETTING
    case TOTAL_GOALS_IN_MATCH
    
    func getTitle() -> String {
        switch self {
        case .MATCH_BETTING, .WIN_DRAW_WIN:
            return "Match Odds"
        case .TOTAL_GOALS_IN_MATCH:
            return "Goals in Match"
        }
    }
}
