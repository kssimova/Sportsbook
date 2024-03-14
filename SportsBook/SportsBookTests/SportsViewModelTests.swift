//
//  SportsViewModelTests.swift
//  SportsBookTests
//
//  Created by Kristina Simova on 13.03.24.
//

import Foundation

import XCTest
@testable import SportsBook

class SportsViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: SportsViewModel!
    var communicationManager: CommunicationManagerMock!
    let environment: Environment = .development
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        communicationManager = CommunicationManagerMock()
        viewModel = SportsViewModel(communicationManager: communicationManager, environment: environment)
    }
    
    override func tearDown() {
        viewModel = nil
        communicationManager = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testFetchSportsSuccess() {
        // Setup
        let expectation = XCTestExpectation(description: "Fetch sports success")
        let sportsResponseData = SportsResponseData(data: [Sport(id: 1, name: "Football")])
        communicationManager.setResult(.success(sportsResponseData))
        
        // Exercise
        viewModel.fetchSports { result in
            // Verify
            switch result {
            case .success(let data):
                XCTAssertEqual(data.data.count, 1)
                XCTAssertEqual(data.data[0].name, "Football")
                XCTAssertEqual(self.viewModel.sports.count, 1)
                XCTAssertEqual(self.viewModel.sports[0].name, "Football")
                expectation.fulfill()
            case .failure:
                XCTFail("Fetch sports should not fail")
            }
        }
        
        // Wait for expectation
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchSportsFailure() {
        // Setup
        let expectation = XCTestExpectation(description: "Fetch sports failure")
        let error: APIError = .unknown
        communicationManager.setResultError(data: Data(), error: error)
        
        // Exercise
        viewModel.fetchSports { result in
            // Verify
            switch result {
            case .success:
                XCTFail("Fetch sports should fail")
            case .failure(let error):
                XCTAssertEqual(error, .unknown)
                XCTAssertEqual(self.viewModel.sports.count, 0)
                expectation.fulfill()
            }
        }
        
        // Wait for expectation
        wait(for: [expectation], timeout: 5.0)
    }
}
