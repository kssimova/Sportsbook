//
//  EventsViewModel.swift
//  Sportsbook
//
//  Created by Kristina Simova on 12.03.24.
//

import Foundation

/**
 *  View model responsible for managing events data.
 */
class EventsViewModel {
    let communicationManager: CommunicationManager
    let environment: Environment
    
    var sportID: Int = 0
    var events: [Event] = []
    
    /**
     *  Initializes the EventsViewModel with the provided dependencies.
     *
     *  - Parameters:
     *    - communicationManager: The communication manager used to make API requests.
     *    - environment: The environment indicating the API base URL.
     *    - sportID: The ID of the sport for which events are fetched.
     */
    init(communicationManager: CommunicationManager, environment: Environment, sportID: Int) {
        self.communicationManager = communicationManager
        self.environment = environment
        self.sportID = sportID
    }
    
    /**
     *  Fetches events for the specified sport ID.
     *
     *  - Parameter completion: A closure to be executed when the request is completed, containing a Result enum with either the fetched events or an error.
     */
    func fetchEventsBySportId(completion: @escaping (Result<ResponseData, APIError>) -> Void) {
        communicationManager.request(endpoint: .events(sportID: sportID, environment: environment), responseType: ResponseData.self) { [weak self] result in
            switch result {
            case .success(let events):
                self?.transformData(responseData: events)
                completion(.success(events))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /**
     *  Transforms the fetched event data into a more structured format.
     *
     *  - Parameter responseData: The raw response data containing event information.
     */
    private func transformData(responseData: ResponseData) {
        // Group events by date and sort them
        let sortedEvents = responseData.data
            .sorted { $0.date < $1.date }
            .reduce(into: [Date: [EventData]]()) { result, eventData in
                let date = eventData.date.startOfDay()
                result[date, default: []].append(eventData)
            }

        // Create Event instances from sorted grouped events
        self.events = sortedEvents.map { date, matches in
            Event(date: date, matches: matches)
        }

        // Sort the events by date
        self.events.sort { $0.date < $1.date }
    }
    
    /**
     Formats the given date into a string with the specified date format.

     - Parameters:
        - dateFormat: The desired format for the date string.
        - date: The date to be formatted.

     - Returns: A string representing the formatted date.
     */
    func getFormattedDate(dateFormat: String, date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: date)
    }
}
