//
//  SportsViewModel.swift
//  Sportsbook
//
//  Created by Kristina Simova on 12.03.24.
//

import Foundation

/**
 *  Represents a view model for managing sports-related data and interactions.
 */
class SportsViewModel {
    let communicationManager: CommunicationManager
    let environment: Environment
    
    /// An array to hold the fetched sports data.
    var sports: [Sport] = []
    
    /// A closure to handle the selection of a sport.
    var didSelectSport: ((Int) -> Void)?
    
    /**
     *  Initializes a SportsViewModel with the provided CommunicationManager and Environment.
     *
     *  - Parameters:
     *    - communicationManager: The communication manager responsible for handling API requests.
     *    - environment: The environment configuration.
     */
    init(communicationManager: CommunicationManager, environment: Environment) {
        self.communicationManager = communicationManager
        self.environment = environment
    }
    
    /**
     *  Fetches sports data from the API.
     *
     *  - Parameter completion: A completion handler to be called when the request completes.
     */
    func fetchSports(completion: @escaping (Result<SportsResponseData, APIError>) -> Void) {
        communicationManager.request(endpoint: .sports(environment: environment), responseType: SportsResponseData.self) { [weak self] result in
            switch result {
            case .success(let sports):
                self?.sports = sports.data
                completion(.success(sports))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
