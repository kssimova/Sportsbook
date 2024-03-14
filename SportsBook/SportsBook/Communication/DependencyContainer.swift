//
//  DependencyContainer.swift
//  SportsBook
//
//  Created by Kristina Simova on 13.03.24.
//

import Foundation

/**
 Singleton class responsible for managing dependencies within the application.
 */
class DependencyContainer {
    /// Shared instance of `DependencyContainer`.
    static let shared = DependencyContainer()
    
    /// Instance of `CommunicationManager` used for network communication.
    let communicationManager: CommunicationManager
    
    /// View model for handling sports-related data.
    let sportsViewModel: SportsViewModel
    
    /// View model for handling events-related data.
    let eventsViewModel: EventsViewModel
    
    /**
     Initializes the dependency container and its dependencies.
     */
    private init() {
        // Initialize the CommunicationManager
        communicationManager = CommunicationManager(baseURL: Environment.development.baseURL,
                                                    session: URLSession.shared,
                                                    authToken: "ewogICAibmFtZSI6ICJHdWVzdCIKfQ==")
        
        // Initialize the view models
        sportsViewModel = SportsViewModel(communicationManager: communicationManager, environment: .development)
        eventsViewModel = EventsViewModel(communicationManager: communicationManager, environment: .development, sportID: 0) // Set initial sport ID to 0
    }
}
