# My Diary - Memories Forever

## Download

You can download the latest version of "My Diary - Memories Forever" on your Android device using the following link:

[Download My Diary - Memories Forever](https://play.google.com/store/apps/details?id=com.dayproduction.diary)

## Project Overview

This Flutter project is a diary app named "My Diary - Memories Forever." The project follows a simplified folder structure (MVVM) for clarity and ease of understanding.

## File Structure

```
lib/
│
├── data/
│   ├── models/                // Data models
│   ├── repositories/          // Data repositories
│   └── services/              // Data services (API, database)
│
├── presentation/
│   ├── pages/                 // Screens/pages
│   └── viewmodels/            // View models
│
└── utils/                     // Utility functions, constants, helpers
```

## Layers Breakdown

**Data Layer (`data`):**
   - **Models (`models`):**
      Houses data models used within the application.
   - **Services (`services`):**
      Manages data services, such as API calls and database operations.
   - **Repositories (`repositories`):**
      Handles data repositories responsible for interacting with data services.

**Presentation Layer (`presentation`):**
   - Manages the user interface (UI) and user experience (UX) aspects.
   - Subfolders:
     - **Pages (`pages`):**
       Contains the pages of the application.
     - **View Models (`viewmodels`):**
       Contains the view models responsible for handling UI logic and data presentation.
     - **Theme (`theme`):**
       Houses the files for managing the app's visual theme, including color schemes, typography, and other design-related configurations.      
     - **Util (`util`):**
       Contains utility functions related to the presentation, such as image pick, handling date/time operations, or performing common calculations.
     - **navigation (`navigation`):**
       Contains screen_transitions for handling screen transitions, including animations, route management, and navigation logic.


**Main Files:**
   - `main.dart`: Entry point of the Flutter application.
   - `app.dart`: Contains the setup for provider dependency injection.
   - `app_view.dart`: Deals with MaterialApp setup.

## Key Principles

- **Simplicity and Clarity:** The structure focuses on straightforward organization for better understanding.
- **Database Integration:** Utilizes the Hive database for efficient storage and retrieval of diary entries.
- **State Management:** Implements state management using the Provider package for a streamlined user interface.