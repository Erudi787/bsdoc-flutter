# BSDOC Mobile - Flutter Port

## 🚀 Overview

This repository contains the source code for the **BSDOC Mobile App**, a Flutter-based port of the fully functioning [BSDOC Personal Health Management Platform](https://bsdoc-project.vercel.app).

The original BSDOC web application empowers users to manage their health records and get personalized over-the-counter medication suggestions through a user-friendly platform, simplifying their healthcare journey with smart digital tools for better self-care. This mobile application aims to bring these a similar rich experience to Android and iOS devices.

## ✨ Mobile App Vision

The BSDOC mobile app will provide users with a convenient and accessible way to:

* **Check Symptoms:** Input symptoms to receive guidance and potential self-care options.
* **Get Medication Suggestions:** Receive suggestions for over-the-counter (OTC) medications based on symptoms.
* **Manage Health Records:** Securely store and access personal health information.
* **Book Appointments:** Find doctors and schedule appointments.
* **Personalized Experience:** Access health tips and reminders.

## 📱 Target Platforms

* Android
* iOS

## 🛠️ Tech Stack (Mobile)

* **Framework:** Flutter
* **Language:** Dart
* **Backend Integration:** MySQL

## 🌐 Original Web Application Context

The existing BSDOC web platform is built with:

* Next.js
* React
* TypeScript
* Supabase (for backend, auth, and database)
* Tailwind CSS

Understanding the web application's structure and features will be beneficial for the mobile porting process.

## 🚦 Current Status

* [ ] Initial project setup complete.
* [ ] Repository created for Flutter ground-app port.
* [ ] UI/UX design for mobile (In Progress / To-Do)
* [ ] MySQL Database Integration (To-Do)
* [ ] Feature porting (To-Do)

## 🚀 Getting Started (Flutter App)

To get a local copy up and running, follow these simple steps.

### Prerequisites

* Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
* Dart SDK (usually comes with Flutter)
* An editor like VS Code or Android Studio with Flutter plugins.

### Installation

1.  **Clone the repo:**
    ```sh
    git clone [https://github.com/Erudi787/bsdoc-flutter.git](https://github.com/Erudi787/bsdoc-flutter.git) 
    ```
2.  **Navigate to the project directory:**
    ```sh
    cd bscoc-flutter
    ```
3.  **Install dependencies:**
    ```sh
    flutter pub get
    ```
5.  **Run the app:**
    ```sh
    flutter run
    ```

## 📁 Project Structure (Tentative)
````
bsdoc-flutter-app/
├── android/            # Android specific files
├── ios/                # iOS specific files
├── lib/                # Main Dart code
│   ├── main.dart       # Main application entry point
│   ├── src/
│   │   ├── core/         # Core services, utilities, constants
│   │   ├── data/         # Data sources (API clients, repositories)
│   │   │   ├── models/
│   │   │   └── supabase/   # Supabase client setup
│   │   ├── presentation/ # UI (Widgets, Screens, State Management)
│   │   │   ├── screens/
│   │   │   ├── widgets/
│   │   │   └── providers_or_blocs/ # For state management
│   │   └── app.dart      # Root application widget
├── test/               # Unit and widget tests
├── pubspec.yaml        # Project dependencies and metadata
└── README.md           # This file
````
## 📄 License

Distributed under the [] License. See `LICENSE` for more information.

## 🙏 Acknowledgements

* The original BSDOC web development team.
* Flutter Community.
* Supabase Team.
