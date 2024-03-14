//
//  DependencyContainerTests.swift
//  SportsBookTests
//
//  Created by Kristina Simova on 13.03.24.
//

import Foundation

import XCTest
@testable import SportsBook

class DependencyContainerTests: XCTestCase {
    
    func testSharedInstance() {
        let instance1 = DependencyContainer.shared
        let instance2 = DependencyContainer.shared
        
        XCTAssertTrue(instance1 === instance2, "Shared instance should always be the same")
    }
    
    func testCommunicationManagerInitialization() {
        let container = DependencyContainer.shared
        
        XCTAssertNotNil(container.communicationManager, "CommunicationManager should not be nil")
        XCTAssertEqual(container.communicationManager.baseURL, Environment.development.baseURL, "BaseURL should match the development environment")
        XCTAssertEqual(container.communicationManager.authToken, "ewogICAibmFtZSI6ICJHdWVzdCIKfQ==", "AuthToken should match the provided value")
    }
    
    func testSportsViewModelInitialization() {
        let container = DependencyContainer.shared
        
        XCTAssertNotNil(container.sportsViewModel, "SportsViewModel should not be nil")
        XCTAssertEqual(container.sportsViewModel.environment, .development, "Environment should match the development environment")
        XCTAssertTrue(container.sportsViewModel.communicationManager === container.communicationManager, "CommunicationManager instance should be shared")
    }
    
    func testEventsViewModelInitialization() {
        let container = DependencyContainer.shared
        
        XCTAssertNotNil(container.eventsViewModel, "EventsViewModel should not be nil")
        XCTAssertEqual(container.eventsViewModel.environment, .development, "Environment should match the development environment")
        XCTAssertTrue(container.eventsViewModel.communicationManager === container.communicationManager, "CommunicationManager instance should be shared")
    }
}
