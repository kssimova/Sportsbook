# Sportsbook App

## Introduction

The Sportsbook app is designed to provide users with access to a catalog of sports and events they can bet on. It allows users to browse available sports, view upcoming events for a selected sport, and place bets on various outcomes.

## Technologies Used

### Development

- **Language**: Swift
- **Framework**: UIKit
- **Minimum iOS Version**: iOS 14

#### Coordinator Pattern

- **Description**: The Coordinator pattern is used to manage the navigation flow of the application. Each coordinator is responsible for coordinating the presentation and dismissal of view controllers within a specific flow or feature of the app.
- **Purpose**: Enhances separation of concerns by decoupling navigation logic from view controllers, making the codebase more modular and easier to maintain. Allows for better coordination of complex navigation scenarios and promotes reusability of navigation logic across different parts of the app.

#### DependencyContainer

- **Description**: The DependencyContainer is a design pattern used to manage the instantiation and configuration of dependencies within an application. It provides a centralized location for registering and resolving dependencies, ensuring that objects are created and configured consistently throughout the app.
- **Purpose**: Promotes loose coupling between components by abstracting away the details of dependency creation and configuration. Facilitates dependency injection, which enables easier testing and swapping of dependencies, leading to more modular and testable code.

#### ViewModels

- **Description**: ViewModels are classes or structs responsible for managing the presentation logic and state of a view or view controller in an iOS app. They encapsulate the data and behavior needed to drive the user interface and interact with the underlying data model or services.
- **Purpose**: Helps to separate business logic from presentation logic, improving the maintainability and testability of the code. Enables the adoption of the MVVM (Model-View-ViewModel) architectural pattern, which promotes a clear separation of concerns and facilitates unit testing of view-related logic.

#### URLSession

- **Description**: URLSession is a powerful networking API provided by Apple for making HTTP requests and handling network-related tasks in iOS apps. It provides built-in support for performing tasks such as data retrieval, file downloading, and uploading, as well as handling authentication and security.
- **Purpose**: Enables communication with remote servers and web services, allowing the app to retrieve data, perform actions, and synchronize content with backend systems. Provides a high-level interface for managing network requests and responses, making it easier to implement network-related functionality while ensuring good performance and security.

---

**Note:** The main requirement was to ensure that the Xcode project requires as little setup and configuring as possible, aiming for the ability to open the project file and hit run directly. This was taken into consideration during the development process to ensure ease of use and accessibility for future developers working on the project.

### Testing

- **Testing Framework**: XCTest
- **Code Coverage**: Xcode Code Coverage

## Features

- Display a list of available sports.
- Navigate to view upcoming events for a selected sport.
- View primary market and available selections for each event.
- Place bets on different outcomes.
- Responsive UI for optimal user experience.

## Explanation
The decision to separate the app from the Vapor project was made to keep the concerns of the API and the app separate. By decoupling the two, we achieve better separation of concerns and modularity, which makes the codebase easier to maintain and scale.

Separating the app from the Vapor project also allows for better code organization and management. Each component (the API and the app) can be developed, tested, and deployed independently, leading to a more efficient development process.

Furthermore, separating the app from the Vapor project allows for flexibility in deployment. The API can be deployed to a cloud provider or containerized environment, while the app can be distributed through the App Store or other distribution channels.

Overall, separating the app from the Vapor project enhances modularity, maintainability, and deployment flexibility, leading to a more robust and scalable solution.

## App installation

You should have the VAPOR project installed on your machine. If you do not have it here's an installation guide:

### macOS

#### Terminal

```zsh
swift build
swift run App
```

#### Xcode

Open `Package.swift`

Run the app

### Docker

Ensure you have Docker running.

#### Build Docker Image

```zsh
docker-compose build
```

#### Start app

```zsh
docker-compose up app
```

#### Stop app

```zsh
docker-compose down
```

### Using

The web server binds to the default port of `8080` on `localhost`.

i.e. `http://localhost:8080`

### To run the app locally, follow these steps:

1. Clone the repository to your local machine.
2. Open the Xcode project file (`Sportsbook.xcodeproj`).
3. Build and run the project on a simulator or physical device.

## Future Improvements

- Implement user authentication for personalized betting experience.
- Add support for more betting markets and options.
- Enhance UI with animations and transitions for a more engaging experience.
- Incorporate push notifications for event updates and betting alerts.
- Integrate analytics to track user interactions and optimize app performance.

## Contributors

- [Kristina Simova](https://github.com/kssimova)
