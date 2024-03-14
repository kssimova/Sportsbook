//
//  Coordinator.swift
//  SportsBook
//
//  Created by Kristina Simova on 12.03.24.
//

import Foundation

/**
 Protocol defining the basic behavior of a coordinator.
 */
protocol Coordinator {
    /// Method to start the coordinator.
    func start()
    
    /**
     Method to show details for a specific sport.
     
     - Parameters:
     - sportId: The ID of the sport for which details will be shown.
     - animated: A boolean value indicating whether the navigation should be animated. Default is `true`.
     */
    func showDetails(for sportId: Int, animated: Bool)
}
