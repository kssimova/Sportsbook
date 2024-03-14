//
//  CommunicationManager.swift
//  SportsBook
//
//  Created by Kristina Simova on 12.03.24.
//

import UIKit

/**
 Handles different environments for the backend server.
 */
enum Environment {
    case development
    case staging
    case production

    /**
     The base URL for each environment.
     */
    var baseURL: String {
        switch self {
        case .development:
            return "http://localhost:8080"
        case .staging:
            return "https://staging.sportsbook.com"
        case .production:
            return "https://sportsbook.com"
        }
    }
}

/**
 Represents different endpoints available in the backend server.
 */
enum Endpoint: Hashable {
    case status(environment: Environment)
    case sports(environment: Environment)
    case sport(sportID: Int, environment: Environment)
    case events(sportID: Int, environment: Environment)
    case test

    /**
     The path for each endpoint.
     */
    var path: String {
        switch self {
        case .status(let environment):
            return environment.baseURL + "/status"
        case .sports(let environment):
            return environment.baseURL + "/sports"
        case .sport(let sportID, let environment):
            return environment.baseURL + "/sports/\(sportID)"
        case .events(let sportID, let environment):
            return environment.baseURL + "/sports/\(sportID)/events"
        case .test:
            return Environment.development.baseURL + "/testEndpoint"
        }
    }

    /**
     The HTTP method for each endpoint.
     */
    var method: String {
        return "GET"
    }

    /**
     Whether authentication is required for each endpoint.
     */
    var requiresAuthentication: Bool {
        switch self {
        case .status, .test:
            return false
        case .sports, .sport, .events:
            return true
        }
    }
}

/**
 Represents different errors that can occur during API communication.
 */
enum APIError: Error, Codable {
    case invalidURL
    case invalidResponse
    case authenticationError
    case unauthorized
    case notFound
    case serverError
    case decodingError
    case unknown
}

/**
 Handles communication with the backend server by sending requests and processing responses.
 */
class CommunicationManager {
    let baseURL: String
    let session: URLSession
    let authToken: String
    
    /**
     Initializes the communication manager with the provided parameters.
     */
    init(baseURL: String, session: URLSession, authToken: String) {
        self.baseURL = baseURL
        self.session = session
        self.authToken = authToken
    }

    /**
     Sends a network request to the specified endpoint.
     */
    func request<T: Decodable>(endpoint: Endpoint, responseType: T.Type, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = URL(string: endpoint.path) else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        
        // Set the authorization token
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")

        session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(.unknown))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }

            switch httpResponse.statusCode {
            case 200...299:
                guard let data = data else {
                    completion(.failure(.invalidResponse))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let decodedResponse = try decoder.decode(T.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(.decodingError))
                }
            case 401:
                completion(.failure(.authenticationError))
            case 403:
                completion(.failure(.unauthorized))
            case 404:
                completion(.failure(.notFound))
            default:
                completion(.failure(.serverError))
            }
        }.resume()
    }
}

