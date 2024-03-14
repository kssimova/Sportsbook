//
//  EventTableViewCellViewModel.swift
//  Sportsbook
//
//  Created by Kristina Simova on 13.03.24.
//

import Foundation

/**
 Model representing the view model for an event table view cell.
 */
struct EventTableViewCellViewModel {
    /// The match data associated with the view model.
    let match: EventData
    
    /**
     Initializes the view model with match data.
     
     - Parameter match: The match data to be associated with the view model.
     */
    init(match: EventData) {
        self.match = match
    }
    
    /// Computed property representing the name of the event.
    var eventName: String {
        return match.name
    }
    
    /// Computed property representing the market type of the event.
    var marketType: String {
        return match.primaryMarket.type.getTitle()
    }
    
    /// Computed property representing the date of the event.
    var date: Date {
        return match.date
    }
    
    /**
     Gets label for Win-Draw-Win market type based on item index.
     */
    func getWinDrawWinLabelLabel(by item: Int) -> String {
        switch item {
        case 0:
            return "Home"
        case 1:
            return "Draw"
        case 2:
            return "Away"
        default:
            return ""
        }
    }
}
