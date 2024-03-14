//
//  CommunicationManagerTests.swift
//  SportsBookTests
//
//  Created by Kristina Simova on 13.03.24.
//

import Foundation

import XCTest
@testable import SportsBook

//class URLSessionMock: URLSession {
//    var mockData: Data?
//    var mockResponse: URLResponse?
//    var mockError: Error?
//
//    static func makeMockSession() -> URLSession {
//        let configuration = URLSessionConfiguration.ephemeral
//        configuration.protocolClasses = [URLProtocolMock.self]
//        return URLSession(configuration: configuration)
//    }
//}

class CommunicationManagerTests: XCTestCase {
    
    func testRequestSuccess() {
        let baseURL = "http://localhost:8080"
        let session = URLSessionMock()
        let authToken = "Bearer testAuthToken"

        let communicationManager = CommunicationManager(baseURL: baseURL, session: session, authToken: authToken)
        
        let expectation = XCTestExpectation(description: "Response received")
        let endpoint = "/testEndpoint"
        let responseData = Data("{\"testKey\":\"testValue\"}".utf8)
        session.mockData = responseData
        session.mockResponse = HTTPURLResponse(url: URL(string: baseURL + endpoint)!, statusCode: 200, httpVersion: nil, headerFields: nil)

        communicationManager.request(endpoint: .test, responseType: TestResponse.self) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.testKey, "testValue")
                expectation.fulfill()
            case .failure:
                XCTFail("Request should succeed")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testRequestFailure() {
        let baseURL = "http://localhost:8080"
        let session = URLSessionMock()
        let authToken = "Bearer testAuthToken"

        let communicationManager = CommunicationManager(baseURL: baseURL, session: session, authToken: authToken)
        
        let expectation = XCTestExpectation(description: "Response received")
        session.mockError = NSError(domain: "Test", code: 123, userInfo: nil)

        communicationManager.request(endpoint: .test, responseType: TestResponse.self) { result in
            switch result {
            case .success:
                XCTFail("Request should fail")
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testEndpointPathConstruction() {
        // Define test environments
        let developmentEnvironment = Environment.development
        let stagingEnvironment = Environment.staging
        let productionEnvironment = Environment.production
        
        // Define test sport ID
        let sportID = 123
        
        // Define expected endpoint paths for each environment and endpoint case
        let expectedDevelopmentPaths: [Endpoint: String] = [
            .status(environment: developmentEnvironment): "http://localhost:8080/status",
            .sports(environment: developmentEnvironment): "http://localhost:8080/sports",
            .sport(sportID: sportID, environment: developmentEnvironment): "http://localhost:8080/sports/123",
            .events(sportID: sportID, environment: developmentEnvironment): "http://localhost:8080/sports/123/events",
            .test: "http://localhost:8080/testEndpoint"
        ]
        
        let expectedStagingPaths: [Endpoint: String] = [
            .status(environment: stagingEnvironment): "https://staging.sportsbook.com/status",
            .sports(environment: stagingEnvironment): "https://staging.sportsbook.com/sports",
            .sport(sportID: sportID, environment: stagingEnvironment): "https://staging.sportsbook.com/sports/123",
            .events(sportID: sportID, environment: stagingEnvironment): "https://staging.sportsbook.com/sports/123/events",
            .test: "http://localhost:8080/testEndpoint"
        ]
        
        let expectedProductionPaths: [Endpoint: String] = [
            .status(environment: productionEnvironment): "https://sportsbook.com/status",
            .sports(environment: productionEnvironment): "https://sportsbook.com/sports",
            .sport(sportID: sportID, environment: productionEnvironment): "https://sportsbook.com/sports/123",
            .events(sportID: sportID, environment: productionEnvironment): "https://sportsbook.com/sports/123/events",
            .test: "http://localhost:8080/testEndpoint"
        ]
        
        // Test endpoint paths for each environment
        for (endpoint, expectedPath) in expectedDevelopmentPaths {
            XCTAssertEqual(endpoint.path, expectedPath)
        }
        
        for (endpoint, expectedPath) in expectedStagingPaths {
            XCTAssertEqual(endpoint.path, expectedPath)
        }
        
        for (endpoint, expectedPath) in expectedProductionPaths {
            XCTAssertEqual(endpoint.path, expectedPath)
        }
    }

}

// Define a mock URLSession for testing purposes
class URLSessionMock: URLSession {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionDataTask {
            completionHandler(self.mockData, self.mockResponse, self.mockError)
        }
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}

// Define a test response struct for testing purposes
struct TestResponse: Decodable {
    let testKey: String
}
