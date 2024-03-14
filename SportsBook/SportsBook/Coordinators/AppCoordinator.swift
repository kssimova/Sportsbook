//
//  AppCoordinator.swift
//  SportsBook
//
//  Created by Kristina Simova on 12.03.24.
//

import UIKit

/**
 Coordinator responsible for managing the navigation flow of the application.
 */
class AppCoordinator: Coordinator {
    /// The navigation controller used for navigation.
    let navigationController: UINavigationController

    /**
     Initializes the coordinator with the provided navigation controller.
     
     - Parameter navigationController: The navigation controller to be used.
     */
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    /// Starts the coordinator's navigation flow.
    func start() {
        // Access the CommunicationManager from the DependencyContainer
        _ = DependencyContainer.shared.communicationManager
        
        // Initialize the SportsViewModel using the communication manager
        let sportsViewModel = DependencyContainer.shared.sportsViewModel
        sportsViewModel.didSelectSport = { [weak self] sportId in
            self?.showDetails(for: sportId)
        }
        
        // Initialize the SportsViewController with the SportsViewModel
        let viewController = SportsViewController()
        viewController.viewModel = sportsViewModel
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    /**
     Navigates to the details view for the selected sport.
     
     - Parameter sportId: The ID of the selected sport.
     */
    func showDetails(for sportId: Int, animated: Bool = true) {
        // Access the EventsViewModel from the DependencyContainer
        let eventsViewModel = DependencyContainer.shared.eventsViewModel
        eventsViewModel.sportID = sportId
        
        // Initialize the EventsViewController with the EventsViewModel
        let eventsViewController = EventsViewController()
        eventsViewController.viewModel = eventsViewModel
        navigationController.pushViewController(eventsViewController, animated: animated)
    }
}
