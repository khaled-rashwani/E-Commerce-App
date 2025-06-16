# 🛒 E-Commerce App

A cross-platform e-commerce application built using **Flutter**. This app features clean architecture, state management using **Bloc/Cubit**, and integrates APIs for product listings, user authentication, and shopping cart functionality.

---
## 🎬 Project Promo
Get a quick overview of the E-Commerce App and its key features by watching the project promo video:
https://www.youtube.com/watch?v=L70aq_5Vn7I

## 📁 Project Structure

```
e_commerce/
├── lib/
│   ├── cubit/                  # State management using Bloc/Cubit
│   │   ├── AuthCubit/          # Handles authentication logic
│   │   ├── CartCubit/          # Manages shopping cart state
│   │   ├── ProductCubit/       # Fetches and manages product data
│   │   └── ...                 # Other cubits per feature
│   │
│   ├── models/                 # Data models (Product, Order, etc.)
│   │
│   ├── shared/                 # Shared utilities and components
│   │   ├── components.dart         # Reusable UI widgets
│   │   ├── network/                # Dio client configuration
│   │   └── sharedPreferences.dart # Local storage helper
│   │
│   └── ui/                     # UI screens and widgets
│       ├── onBoarding.dart
│       └── User/
│           ├── Auth/               # Login, Register screens
│           ├── Home/               # Home, Profile, Store views
│           ├── ProductDetails.dart
│           └── cart.dart
│
├── assets/                     # Static assets
│   └── images/
│
├── android/                    # Android platform code
├── ios/                        # iOS platform code
├── web/                        # Web platform code
└── pubspec.yaml                # Dependencies and project metadata
```

---

## 🚀 Features

* 🔐 **Authentication** (Login/Register)
* 🏪 **Product Listings**
* 🛍️ **Shopping Cart**
* 📦 **Product Details View**
* 🧠 **State Management** using `flutter_bloc`
* 🌐 **API Integration** via `dio`
* 💾 **Local Storage** with Shared Preferences
* 📱 **Responsive UI** for Android, iOS, and Web

---

## 🧱 Dependencies

Key dependencies used in this project:

* `flutter_bloc`: State management
* `dio`: Networking
* `shared_preferences`: Local storage
* `equatable`: For value equality in state classes
* `flutter_svg`: SVG asset rendering

Check full dependencies in [`pubspec.yaml`](./pubspec.yaml).

---

## 🛠️ Getting Started

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/e_commerce.git
   cd e_commerce
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**

   ```bash
   flutter run
   ```

---

## 🌍 Platform Support

| Platform | Supported |
| -------- | --------- |
| Android  | ✅         |
| iOS      | ✅         |
| Web      | ✅         |

---

## 🤝 Contributing

Feel free to fork the repo and submit a pull request! Bug reports, feature suggestions, and UI enhancements are all welcome.

---

## 📄 License

This project is licensed under the **MIT License**. See the [LICENSE](./LICENSE) file for details.
