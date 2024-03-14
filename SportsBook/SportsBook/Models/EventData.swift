//
//  EventData.swift
//  SportsBook
//
//  Created by Kristina Simova on 12.03.24.
//

import UIKit

struct EventData: Codable {
    let name: String
    let primaryMarket: PrimaryMarket
    let date: Date
    let id: String
}
