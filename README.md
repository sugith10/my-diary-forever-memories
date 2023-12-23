# My Diary - Memories Forever

## Download

You can download the latest version of "My Diary - Memories Forever" on your Android device using the following link:

[Download My Diary - Memories Forever](https://www.amazon.com/dp/B0CPC9V42B/ref=apps_sf_sta)

## Project Overview

This Flutter project is a diary app named "My Diary - Memories Forever." The project has been restructured for simplicity and clarity, following a more straightforward folder structure.

## File Structure

```
lib
|-- model
|   |-- database_model.dart
|
|-- controller
|   |-- database_controller.dart
|
|-- provider
|   |-- state_management_provider.dart
|
|-- presentation
|   |-- screen
|       |-- screen.dart
|   |-- theme
|       |-- app_theme.dart
|   |-- util
|       |-- screen_functions.dart
|
|-- main.dart
```

## Layers Breakdown

1. **Model Layer (`models`):**
   - Contains the database model (`database_model.dart`) representing the structure of the data stored in Hive.

2. **Controller Layer (`controllers`):**
   - Manages database-related functions and operations.
   - Houses the `database_controller.dart` file, where database functionalities are implemented.

3. **Provider Layer (`provider`):**
   - Handles state management using the Provider package.
   - Includes the `state_management_provider.dart` file.

4. **Presentation Layer (`presentation`):**
   - Manages the user interface (UI) and user experience (UX) aspects.
   - Includes three subfolders:
     - **Screen (`screen`):**
       - Contains the main screen of the diary app (`screen.dart`).
     - **Theme (`theme`):**
       - Houses the `app_theme.dart` file for managing the app's visual theme.
     - **Util (`util`):**
       - Contains `screen_functions.dart` with utility functions related to the screen.

## Key Principles

- **Simplicity and Clarity:** The updated structure focuses on straightforward organization for better understanding.
- **Database Integration:** Utilizes the Hive database for efficient storage and retrieval of diary entries.
- **State Management:** Implements state management using the Provider package for a streamlined user interface.