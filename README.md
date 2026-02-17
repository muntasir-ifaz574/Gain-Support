# Gain Solutions Flutter App

A production-ready Flutter application demonstrating Clean Architecture, MVC pattern, and Riverpod state management.

## Architecture

The project follows a strict **MVC (Model-View-Controller)** pattern with **Riverpod** for state management.

### Folder Structure
```
lib/
├── core/           # Constants, Theme, Routes, Utils
├── models/         # Data Models (Ticket, Filter, Contact, User)
├── views/          # UI Screens (Ticket, Filter, Contact, Profile)
├── controllers/    # Business Logic & State Management (Riverpod)
├── services/       # API Simulation Service
└── widgets/        # Reusable Components
```

### Key Decisions
- **Riverpod**: Chosen for its compile-time safety, easy testing, and separation of concerns.
- **MVC**: Clear separation between UI (Views), Logic (Controllers), and Data (Models).
- **Dynamic UI**: The Filter screen is generated dynamically based on API response, demonstrating flexibility.
- **Theme**: A custom `AppTheme` is used to ensure consistency and a premium feel.

## Features

1.  **Ticket System**:
    - Lists tickets with status, priority badges, and tags.
    - Simulates network delay and loading states.
2.  **Dynamic Filter**:
    - Fetches filter configuration from API.
    - Renders Dropdowns, TextFields, or DatePickers dynamically.
3.  **Contacts**:
    - Searchable contact list with debouncing (300ms).
    - Optimistic UI updates.
4.  **Profile**:
    - Premium UI design with Hero animations.
    - Stats cards and detailed user info.

## How to Run

1.  **Install Dependencies**:
    ```bash
    flutter pub get
    ```

2.  **Run the App**:
    ```bash
    flutter run
    ```

## Testing

The codebase is structured to be easily testable.
- **Controllers** rely on abstract `ApiService` (which can be mocked).
- **UI** is logic-free and depends only on providers.

## Assumptions
- The API is simulated using `Future.delayed`.
- Icons and specific UI elements are based on the provided reference text descriptions.
