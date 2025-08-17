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
* 🌐 Fetch data via API integration

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

## 📦 Release APK

To generate a release APK for Android:

### 1. Build APK

```bash
flutter build apk --release
```

This will generate the APK at:

```
build/app/outputs/flutter-apk/app-release.apk
```

### 2. (Optional) Build App Bundle (for Play Store)

```bash
flutter build appbundle --release
```

This will generate an `.aab` file at:

```
build/app/outputs/bundle/release/app-release.aab
```

---

## 📌 Roadmap

* [ ] Add dark mode support
* [ ] Implement event search & filtering
* [ ] Push notifications for upcoming events
* [ ] Offline support

---

## 🤝 Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to change.

---

## 📄 License

This project is licensed under the MIT License.
<img width="458" height="803" alt="Screenshot 2025-08-17 225454" src="https://github.com/user-attachments/assets/7ac96289-8ad7-406f-9013-986d668703ea" />
<img width="471" height="798" alt="Screenshot 2025-08-17 225522" src="https://github.com/user-attachments/assets/c4f0e926-e127-4aab-a74c-176fbf447846" />
<img width="461" height="818" alt="Screenshot 2025-08-17 225625" src="https://github.com/user-attachments/assets/b49fdb7e-f6dd-474d-aa2b-a420e8d98ade" />
<img width="453" height="790" alt="Screenshot 2025-08-17 225410" src="https://github.com/user-attachments/assets/b7684f65-f2cf-41bb-bf79-2aa0334c5f67" />

