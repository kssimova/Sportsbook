//
//  CommunicationManagerFactory.swift
//  SportsBook
//
//  Created by Kristina Simova on 12.03.24.
//

import UIKit

/**
Factory class responsible for creating instances of `CommunicationManager`.
 */

class CommunicationManagerFactory {
    
    /// Creates and returns an instance of `CommunicationManager` with default configurations.
    ///
    /// - Returns: An instance of `CommunicationManager`.
    static func makeCommunicationManager() -> CommunicationManager {
        let baseURL = "http://localhost:8080"
        let session = URLSession.shared
        let authToken = "Bearer ewogICAibmFtZSI6ICJHdWVzdCIKfQ==" // Example auth token
        
        return CommunicationManager(baseURL: baseURL, session: session, authToken: authToken)
    }
}
