# Football Leagues App

This project implements an iOS application utilizing Clean Architecture, MVVM-C pattern, SwiftUI, async/await, and various technologies for effective data management and network communication.

## Table of Contents

- [Introduction](#introduction)
- [Key Features](#key-features)
- [Requirements](#requirements)
- [Architecture and Design](#architecture-and-design)
- [Technologies Used](#technologies-used)
- [Getting Started](#getting-started)

## Introduction

This iOS application follows Clean Architecture principles, MVVM-C pattern, and leverages SwiftUI, async/await, and Combine for efficient UI development, concurrent programming, and reactive programming. Key features include data persistence using Core Data, asynchronous updates from web APIs, and manual dependency injection using dependency containers.

## Key Features

- **Clean Architecture**: Organized codebase following clean architecture principles.
- **MVVM-C Pattern**: Utilizes Model-View-ViewModel-Coordinator pattern for presentation.
- **SwiftUI**: Modern UI framework for building declarative and reactive interfaces.
- **async/await**: Utilizes async functions and await to handle asynchronous tasks elegantly.
- **Combine Framework**: Leverages Combine for reactive programming and event handling.
- **Core Data**: Implements data persistence using Core Data framework.
- **Network Communication**: Uses URLSession for network communication and Codable for JSON decoding.

## Requirements

- iOS 14+
- Xcode 12+
- Swift 5

## Architecture and Design

The application is structured following Clean Architecture and MVVM-C pattern, ensuring separation of concerns, maintainability, and testability.

- **Clean Architecture Layers**:
  - **Entities**: Represent domain models.
  - **Use Cases**: Contains business logic.
  - **Repositories**: Abstract interfaces for data operations.
  - **Dependency Injection**: Manages dependencies and their injection.

- **MVVM-C Pattern**:
  - **Model**: Represents the data and business logic.
  - **View**: Responsible for UI and UI-related logic.
  - **ViewModel**: Mediates communication between Model and View.
  - **Coordinator**: Handles navigation flow.

## Technologies Used

- Swift
- SwiftUI
- async/await
- Combine
- Core Data
- URLSession
- Codable

## Getting Started

1. Clone the repository.
2. Open the Xcode project.
3. Build and run the application on an iOS 14+ simulator or device.

