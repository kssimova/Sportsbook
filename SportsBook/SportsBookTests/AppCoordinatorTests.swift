//
//  AppCoordinatorTests.swift
//  SportsBookTests
//
//  Created by Kristina Simova on 13.03.24.
//

import Foundation

import XCTest
@testable import SportsBook

class AppCoordinatorTests: XCTestCase {

    func testStart() {
        // Create a mock navigation controller
        let navigationController = UINavigationController()
        let appCoordinator = AppCoordinator(navigationController: navigationController)
        
        // Start the coordinator's navigation flow
        appCoordinator.start()
        
        // Verify that the navigation controller's stack contains the SportsViewController
        XCTAssertTrue(navigationController.viewControllers.first is SportsViewController)
    }
    
    func testShowDetails() {
        // Create a mock navigation controller
        let navigationController = UINavigationController()
        let appCoordinator = AppCoordinator(navigationController: navigationController)
        
        // Start the coordinator's navigation flow
        appCoordinator.start()
        
        // Trigger the showDetails method with a mock sport ID
        appCoordinator.showDetails(for: 123, animated: false)
        
        // Ensure that the navigation controller's stack now contains the EventsViewController
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        
        // Retrieve the last view controller on the navigation stack
        guard let eventsViewController = navigationController.viewControllers.last as? EventsViewController else {
            XCTFail("EventsViewController not found")
            return
        }
        
        // Assert that the EventsViewController's viewModel is properly set
        XCTAssertNotNil(eventsViewController.viewModel)
        // Assuming there's a property in EventsViewModel representing the sportID
        XCTAssertEqual(eventsViewController.viewModel?.sportID, 123)
    }


}
