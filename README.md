E-Commerce App

A feature-rich e-commerce mobile application built with Flutter. This project provides a complete shopping experience, from browsing products and managing a cart to placing orders and viewing order history.

✨ Features

Based on the project structure, this app includes the following features:

User Authentication: Secure login and registration.

Onboarding: Introductory screens for new users.

Dynamic Home Page: Featuring banners, categories, and products.

Product Management:

View products by category, store, or tags.

Detailed product view with images, description, sizes, and colors.

User ratings and comments on products.

Search Functionality: Easily search for products.

Shopping Cart: Add, remove, and manage items in the cart.

Favorites/Wishlist: Save products for later.

Order Management:

Place new orders.

View order history and details.

Stores & Categories: Browse products based on different stores and nested categories.

User Profile: View and manage user information.

🚀 Tech Stack & Architecture

This project is built using a modern, scalable tech stack and a clean architecture.

Framework: Flutter

State Management: BLoC / Cubit for predictable and scalable state management.

Networking: Dio for making HTTP requests to a backend API.

Local Storage: SharedPreferences for persisting simple data like auth tokens or user settings.

Architecture: The project follows a Feature-Driven architecture, where the code is organized by features (e.g., Auth, Cart, Product). This makes the codebase easier to maintain and scale.

UI Components: Custom-built widgets for a consistent and beautiful user interface.

📂 Project Structure

The project directory is structured to separate concerns and features, making it easy to navigate and build upon.

e_commerce/
├── lib/
│   ├── cubit/          # State management (Bloc/Cubit) for each feature
│   │   ├── AuthCubit/
│   │   ├── CartCubit/
│   │   ├── ProductCubit/
│   │   └── ...
│   │
│   ├── models/         # Data models for API responses (e.g., Product, Order)
│   │
│   ├── shared/         # Shared code
│   │   ├── components.dart     # Reusable UI widgets
│   │   ├── network/            # Dio network client setup
│   │   └── sharedPreferences.dart # Local storage helper
│   │
│   └── ui/             # UI screens and widgets, organized by feature
│       ├── onBoarding.dart
│       └── User/
│           ├── Auth/           # Login, Register screens
│           ├── Home/           # Home, Profile, Stores screens
│           ├── ProductDetails.dart
│           └── cart.dart
│
├── assets/             # Project assets
│   └── images/
│
├── android/            # Android-specific files
├── ios/                # iOS-specific files
├── web/                # Web-specific files
└── pubspec.yaml        # Dependencies and project metadata

⚙️ Getting Started

Follow these instructions to get the project up and running on your local machine.

Prerequisites

Flutter SDK (version 3.0 or higher recommended)

An IDE like VS Code or Android Studio

A connected device (emulator or physical) or Chrome for web development.

Installation

Clone the repository:

git clone https://github.com/YOUR_USERNAME/YOUR_REPOSITORY_NAME.git
cd YOUR_REPOSITORY_NAME
IGNORE_WHEN_COPYING_START
content_copy
download
Use code with caution.
Sh
IGNORE_WHEN_COPYING_END

Handle the lib.rar file (Important!):
Your project contains a lib.rar file. The primary source code is likely inside it.

Extract the contents of lib.rar.

Replace the existing lib folder in the project with the extracted content.

Delete the lib.rar file. You should not keep compressed source code in a Git repository.

Add .rar to your .gitignore file to prevent it from being committed again.

Install dependencies:
Run the following command in your terminal from the project root:

flutter pub get
IGNORE_WHEN_COPYING_START
content_copy
download
Use code with caution.
Sh
IGNORE_WHEN_COPYING_END

Configure the API Endpoint:
This app requires a backend API. You will need to set the base URL for your API in:
lib/shared/network/dio.dart

Run the app:

flutter run
IGNORE_WHEN_COPYING_START
content_copy
download
Use code with caution.
Sh
IGNORE_WHEN_COPYING_END

This will launch the app on your connected device, emulator, or web browser.

🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the issues page.

📄 License

This project is licensed under the MIT License - see the LICENSE file for details.
