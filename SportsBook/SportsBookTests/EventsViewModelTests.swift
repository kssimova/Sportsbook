//
//  EventsViewModelTests.swift
//  SportsBookTests
//
//  Created by Kristina Simova on 13.03.24.
//

import Foundation

import XCTest
@testable import SportsBook

class EventsViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: EventsViewModel!
    var communicationManager: CommunicationManagerMock!
    let environment: Environment = .development
    let sportID: Int = 1
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        communicationManager = CommunicationManagerMock()
        viewModel = EventsViewModel(communicationManager: communicationManager, environment: environment, sportID: sportID)
    }
    
    override func tearDown() {
        viewModel = nil
        communicationManager = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testFetchEventsBySportId_Success() {
        // Arrange
        let expectation = XCTestExpectation(description: "Fetch events success")
        let eventsResponseData = ResponseData(data: [EventData]())
        communicationManager.setResult(.success(eventsResponseData))
        
        // Act
        viewModel.fetchEventsBySportId { result in
            // Verify
            switch result {
            case .success(let data):
                XCTAssertEqual(data.data.count, 0)
                XCTAssertEqual(self.viewModel.events.count, 0)
                expectation.fulfill()
            case .failure:
                XCTFail("Fetch events should not fail")
            }
        }
        
        // Wait for expectation
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchEventsBySportId_Failure() {
        // Arrange
        let expectation = XCTestExpectation(description: "Fetch events failure")
        let error: APIError = .invalidURL
        communicationManager.mockResult = .failure(error)
        
        viewModel.fetchEventsBySportId { result in
            switch result {
            case .success:
                XCTFail("Fetch events should fail")
            case .failure(let error):
                XCTAssertEqual(error, .invalidURL)
                XCTAssertEqual(self.viewModel.events.count, 0)
                expectation.fulfill()
            }
        }
        
        // Wait for expectation
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetFormattedDate() {
        // Arrange
        let viewModel = EventsViewModel(communicationManager: CommunicationManagerMock(), environment: .development, sportID: 1)
        let date = Date()
        let dateFormat = "dd/MM/yyyy"
        
        // Act
        let formattedDate = viewModel.getFormattedDate(dateFormat: dateFormat, date: date)
        
        // Assert
        XCTAssertEqual(formattedDate, "14/03/2024")
    }
}

// MARK: - CommunicationManagerMock

class CommunicationManagerMock: CommunicationManager {
    var mockResult: Result<Data, APIError>?

    override init(baseURL: String = "", session: URLSession = URLSession.shared, authToken: String = "") {
        super.init(baseURL: baseURL, session: session, authToken: authToken)
    }

    override func request<T: Decodable>(endpoint: Endpoint, responseType: T.Type, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let result = mockResult else {
            XCTFail("Mock result not set")
            return
        }

        switch result {
        case .success(let data):
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                XCTFail("Failed to decode response: \(error)")
                completion(.failure(.decodingError))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    func setResult<T: Codable>(_ result: Result<T, APIError>) {
        switch result {
        case .success(let data):
            do {
                let jsonData = try JSONEncoder().encode(data)
                self.mockResult = .success(jsonData)
            } catch {
                self.mockResult = .failure(.decodingError)
            }
        case .failure(let error):
            self.mockResult = .failure(error)
        }
    }
    
    func setResultError(data: Data, error: APIError?) {
           if let error = error {
               self.mockResult = .failure(error)
           } else {
               self.mockResult = .success(data)
           }
       }
}
