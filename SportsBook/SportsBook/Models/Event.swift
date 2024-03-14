//
//  Event.swift
//  SportsBook
//
//  Created by Kristina Simova on 14.03.24.
//

import Foundation

/// Represents an event, consisting of a date and matches.
struct Event {
    let date: Date
    let matches: [EventData]
}
