# Event Explorer App

A Flutter-based mobile application for exploring, browsing, and managing events. The app integrates with Firebase for authentication and data storage, supports persistent user sessions, and provides a modern UI with reusable widgets.

---

## 📂 Project Structure

```
lib/
│── models/                # Data models (Event, Offer)
│── screens/               # App screens (UI pages)
│   ├── auth/              # Authentication-related screens
│   ├── event_list_screen.dart
│   ├── event_detail_screen.dart
│   ├── main_screen.dart
│   ├── offer_screen.dart
│   ├── profile_screen.dart
│   ├── splash_screen.dart
│── services/              # Firebase + API service layers
│   ├── api_service.dart
│   ├── auth_service.dart
│   ├── offers_service.dart
│   ├── storage_service.dart
│── widgets/               # Reusable UI widgets
│   ├── event_card.dart
│   ├── offer_card.dart
│── firebase_options.dart  # Firebase configuration
│── main.dart              # App entry point
```

---

## 🚀 Features

* 🔐 User authentication (Firebase Auth)
* 🎟️ Browse upcoming events
* 📖 Event details page
* 🧾 Offers and promotions
* 👤 User profile management
* 💾 Persistent storage with `shared_preferences`
* ☁️ Cloud Firestore backend
* 🎨 Custom fonts with `google_fonts`

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_lints: ^3.0.0
  http: ^1.2.0
  shared_preferences: ^2.2.2
  firebase_core: ^3.3.0
  firebase_auth: ^5.2.0
  cloud_firestore: ^5.4.0
  google_fonts: ^6.2.0
```

---

## 🔧 Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/yourusername/event_explorer.git
cd event_explorer
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Setup Firebase

* Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
* Enable Authentication (Email/Password)
* Enable Firestore Database
* Download your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
* Configure Firebase with `flutterfire configure`

### 4. Run the app

```bash
flutter run
```

---

## 📱 Screenshots (to be added)

* Splash Screen
* Login / Signup
* Event List
* Event Details
* Profile Screen

---

## 🧪 Testing

```bash
flutter test
```

---

## 📌 Roadmap

*

---

## 🤝 Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to change.

---

## 📄 License

This project is licensed under the MIT License.

Uses api to fetch data
