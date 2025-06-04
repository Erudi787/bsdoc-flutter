# BSDOC Mobile App

## 🚀 Overview

This repository contains the source code for the **BSDOC Mobile App**, which consists of two main components:
1.  A **Flutter-based mobile application** providing a user-friendly frontend.
2.  A **Python-based API backend** handling data storage, business logic, and serving data to the mobile app.

The app is inspired by the fully functioning [BSDOC Personal Health Management Platform](https://bsdoc-project.vercel.app), which empowers users to manage their health records and get personalized over-the-counter medication suggestions. This mobile application aims to bring a similar rich experience to Android and iOS devices, utilizing its own dedicated backend for enhanced control and customization.

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

## 🛠️ Tech Stack

* **Mobile Frontend:**
    * **Framework:** Flutter
    * **Language:** Dart
    * **HTTP Client:** `http` package
* **Backend API:**
    * **Framework:** Flask
    * **Language:** Python
    * **Database:** MySQL (local testing with WampServer/phpMyAdmin; eyeing Oracle Cloud for remote)
    * **ORM:** Flask-SQLAlchemy
    * **Database Connector:** PyMySQL

## 🌐 Original Web Application Context

The existing BSDOC web platform (`https://bsdoc-project.vercel.app`) is built with:

* Next.js
* React
* TypeScript
* Supabase (for backend, auth, and database)
* Tailwind CSS

**Note:** The mobile application leverages a newly developed Python/MySQL backend and does not directly connect to the Supabase backend of the original web platform.

## 🚦 Current Status

* [x] Initial project setup complete (Flutter frontend and Python backend).
* [x] Repository created for Flutter app and integrated Python backend.
* [x] Local MySQL Database Integration (Backend successfully connects to local DB, table created).
* [x] Backend API Server Running (Basic `/users` endpoint functional).
* [x] Frontend-Backend Communication Established (Flutter app fetches data from local Python API).
* [ ] UI/UX design for mobile (In Progress / To-Do)
* [ ] Feature porting (In Progress / To-Do)
* [ ] Authentication Functionality (Next Major To-Do)

## 🚀 Getting Started

To get a local copy of both the mobile app and its backend up and running, follow these simple steps.

### Prerequisites (General)

* Git
* An editor like VS Code or Android Studio.

### 🚀 Getting Started (Mobile Frontend - Flutter App)

This section covers setting up and running the Flutter mobile application.

#### Prerequisites (Flutter Specific)

* Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
* Dart SDK (usually comes with Flutter)

#### Installation & Running

1.  **Clone the repo:**
    ```sh
    git clone [https://github.com/Erudi787/bsdoc-flutter.git](https://github.com/Erudi787/bsdoc-flutter.git)
    ```
    (Note: The repository name might still be `bsdoc-flutter`, but the internal structure has changed as described below).
2.  **Navigate to the Flutter project directory:**
    ```sh
    cd bsdoc-flutter/flutter_app
    ```
3.  **Install dependencies:**
    ```sh
    flutter pub get
    ```
4.  **Run the app:**
    ```sh
    flutter run
    ```
    * **Important for local backend connection:**
        * For Android Emulator, use `http://10.0.2.2:5000` as your backend URL.
        * For iOS Simulator, use `http://localhost:5000`.
        * For physical devices, use your host machine's local IP address (e.g., `http://192.168.1.5:5000`) and ensure firewall access.

### 🚀 Getting Started (Backend API - Python)

This section covers setting up and running the Flask API backend.

#### Prerequisites (Python Specific)

* Python 3.8+
* `pip` (Python package installer)
* Local MySQL Server (e.g., installed via WampServer, MAMP, XAMPP, or directly MySQL Community Server)
* phpMyAdmin (or another MySQL client like MySQL Workbench/DBeaver) for database management.

#### Installation & Running

1.  **Navigate to the backend project directory:**
    ```sh
    cd bsdoc-flutter/python_backend
    ```
2.  **Create and activate a Python virtual environment:**
    ```bash
    python -m venv venv
    # On Windows:
    .\venv\Scripts\activate
    # On macOS/Linux:
    source venv/bin/activate
    ```
3.  **Install Python dependencies:**
    ```bash
    pip install -r requirements.txt
    ```
    (This will install Flask, Flask-SQLAlchemy, PyMySQL, python-dotenv, and cryptography).

4.  **Local MySQL Database Setup:**
    * Ensure your local MySQL server (e.g., via WampServer) is running.
    * Access phpMyAdmin (usually at `http://localhost/phpmyadmin/`).
    * Create a new database (e.g., `health_app_db`).
    * Create a new user (e.g., `health_app_user`) with a strong password and grant it all privileges on `health_app_db`.
    * Update your `python_backend/config.py` with these database credentials.

5.  **Initialize the Database Tables:**
    * Ensure your virtual environment is active and you are in the `python_backend` directory.
    * Set the Flask application environment variable:
        ```bash
        # On Windows (Command Prompt):
        set FLASK_APP=app.py
        # On Windows (PowerShell):
        $env:FLASK_APP="app.py"
        # On macOS/Linux:
        export FLASK_APP=app.py
        ```
    * Run the database initialization command:
        ```bash
        flask init-db
        ```
        (This will create your `user` table and other models defined in `app.py`).

6.  **Add Test Data (Optional, but recommended):**
    * You can manually add users via phpMyAdmin, or run a Python script like `seed_db.py` (if you create one as previously discussed) to populate initial data.

7.  **Run the Backend API Server:**
    ```bash
    python app.py
    ```
    The server will typically run on `http://127.0.0.1:5000` (or `http://localhost:5000`). Keep this terminal window open and the server running while you develop and test the Flutter app.

## 📁 Project Structure
````
bsdoc-flutter/                  # Your main project repository root
├── .git/
├── .gitignore                  # Combined Git ignore for Flutter and Python
├── flutter_app/                # Your Flutter mobile application
│   ├── android/
│   ├── ios/
│   ├── lib/                    # Main Dart code for frontend
│   │   ├── main.dart
│   │   ├── models/             # Data models (e.g., user.dart)
│   │   ├── services/           # API communication (e.g., user_service.dart)
│   │   └── ... (your other frontend organization)
│   ├── pubspec.yaml
│   └── ... (other Flutter project files)
├── python_backend/             # Your Python API backend
│   ├── venv/                   # Python virtual environment
│   ├── app.py                  # Main Flask application, routes, models
│   ├── config.py               # Database connection and other settings
│   ├── requirements.txt        # Python dependencies
│   ├── seed_db.py (optional)   # Script for adding test data
│   └── .env (ignored)          # Environment variables for sensitive data
└── README.md                   # This file
````

## 📄 License

Distributed under the [] License. See `LICENSE` for more information.

## 🙏 Acknowledgements

* The original BSDOC web development team.
* Flutter Community.
* Flask and SQLAlchemy Communities.
* WampServer Project.