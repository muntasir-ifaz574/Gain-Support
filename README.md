# Gain Support App

Welcome to the **Gain Support** application project. This document serves as a comprehensive guide to the project's architecture, codebase structure, and implemented features.

## Project Structure

The project follows a feature-first, layer-based architecture designed for scalability and maintainability.

```text
lib/
├── controllers/          # Business logic and state management (Riverpod)
│   ├── ticket_controller.dart
│   └── ...
├── core/                 # Shared resources and utilities
│   ├── constants/        # App-wide constants (colors, strings)
│   ├── routes/           # Navigation and routing configuration
│   ├── theme/            # App theme and styling definitions
│   └── utils/            # Helper functions
├── models/               # Data models and JSON serialization
│   ├── ticket_model.dart
│   └── ...
├── services/             # Data access layer (API simulation)
│   ├── api_service.dart
│   └── ...
├── views/                # UI Layer (Screens and Widgets)
│   ├── contact/          # Contact screen feature
│   ├── filter/           # Filter screen feature
│   ├── profile/          # Profile screen feature
│   ├── splash/           # Splash screen feature
│   ├── ticket/           # Ticket list and detail features
│   └── ...
├── widgets/              # Reusable UI components
│   ├── ticket_card.dart
│   └── ...
├── App.dart              # Root widget and app configuration
└── main.dart             # Application entry point
```

## Project Approach

### Architecture: MVC (Model-View-Controller)
We adopted a clean MVC pattern alongside **Riverpod** for state management to ensure a robust and testable codebase.

*   **Model**: Defines the data structures using plain Dart objects.
*   **View**: The UI layer that observes the state. Views are passive and only rebuild when the state changes.
*   **Controller**: Handles user input and business logic. It interacts with the Service layer to fetch data and updates the state, which in turn updates the View.

### State Management: Riverpod
Riverpod was chosen for its:
*   **Compile-time safety**: Catches errors early during development.
*   **Decoupling**: Separates UI from business logic effectively.
*   **Testability**: Makes it easy to mock dependencies and test controllers in isolation.
*   **Scalability**: Handles complex state dependencies efficiently.

### Design Philosophy
*   **Component-Based**: The UI is built using small, reusable widgets (e.g., `TicketCard`) to reduce code duplication.
*   **Feature Isolation**: Features are organized into their own directories within `views/`, making it easy to locate and maintain code related to specific functionality.
*   **Modern Flutter**: Utilizes current best practices, such as `Color.withValues` for better color fidelity and modern Material 3 design principles.

## Features

### 1. User Interface & Experience
*   **Splash Screen**: A branded launch screen that seamlessly transitions to the main app.
*   **Modern Design**: A clean, professional aesthetic using the "Gain Support" brand colors.
*   **Responsive Layouts**: optimises for various potential screen sizes using flexible widgets.

### 2. Ticket Management
*   **Ticket List**: Displays a scrollable list of support tickets with summary details.
*   **Status Indicators**: Visual cues (colors/badges) for different ticket statuses (Open, Closed, Pending).
*   **Search Functionality**:
    *   Located in the AppBar for quick access.
    *   Filters tickets in real-time based on title or ID.
*   **Advanced Filtering**:
    *   Dedicated filter screen.
    *   Allows filtering by status, priority, or date.

### 3. Contact Management
*   **Contact List**: View a list of support contacts.
*   **Profile Images**: Displays user avatars with fallbacks.

### 4. Navigation
*   **Bottom Navigation Bar**: Easy access to Tickets, Contacts, and Profile sections.
*   **Named Routing**: Centralized routing logic in `AppRoutes` for maintainable navigation.
*   **Smooth Transitions**: Custom slide and fade animations between screens.

### 5. Data Handling
*   **Mock API Service**: architecture is ready for real API integration. Currently utilizes an `ApiService` that simulates network delays and returns realistic mock data.
