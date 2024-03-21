<div align="center">

# 🏁 Crosstrack Italia 🏁

</div>

Crosstrack Italia is a comprehensive Flutter application designed for tracking cross-country races across Veneto, Lombardia, and Trentino Alto-Adige. Built with Dart and powered by Firebase, this application serves as a platform for motocross drivers to discover new tracks for training and competing.

---

## 🎯 Main Features

- **Track Discovery**: Utilize a map to locate tracks and a list of tracks that can be filtered by region and type.
- **Track Details**: Each track has a dedicated page with a description, location, type of track, and the ability to add a review.
- **Reviews**: Users can leave reviews for tracks, which are displayed on the track details page.
- **Track Management**: Track owners can manage their track by adding, editing, and deleting track details.
- **User Types**: The application caters to guest users, authenticated users, and track owners with varying levels of access and functionality.
- **Authentication**: Google and Facebook authentication are used for user verification.
- **User Profile**: Authenticated users have a profile page where they can view and edit their details.
- **Favorites**: Users can add tracks to their favorites list for easy access.
- **Search**: Users can search for tracks by name.
- **Responsive Design**: The application is designed to work on both mobile and web platforms.

---

## 🛠️ Technologies

- **Dart**: A client-optimized programming language for fast apps on any platform.
- **Flutter**: A cross-platform UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **Firebase**: A platform developed by Google for creating mobile and web applications (in this application Firestore, Cloud Storage and Authentication were used).
- **OpenStreetMaps API**: A free, editable map of the world that is used to display the tracks on the map.
- **Google Maps API**: A set of APIs that enable applications to display and interact with Google Maps.
- **Facebook Login**: A secure, fast, and convenient way for users to log into an application.
- **Google Sign-In**: A secure authentication system that reduces the burden of login for users.
- **Riverpod 2.0**: A simple way to manage state in Flutter.
- **Freezed**: A code generator for immutable classes that allows you to write less boilerplate code.

---

## 🚀 Getting Started

1. Clone the repository: `git clone https://github.com/yourusername/crosstrack_italia.git`
2. Navigate into the project directory: `cd crosstrack_italia`
3. Install dependencies: `flutter pub get`
4. Run the app: `flutter run`

---

## 📁 Project Structure

The project is organized into several directories (inside the `lib/` directory) that contain the source code for the application. The main directories are as follows:


```plaintext
lib/
├── common
├── features
│   ├── auth
│   │   ├── backend
│   │   └── constants
│   ├── firebase_constants
│   ├── map
│   │   ├── constants
│   │   ├── models
│   │   ├── notifiers
│   │   ├── presentation
│   │   │   └── widget
│   │   │       ├── map_widget
│   │   │       ├── marker
│   │   │       └── panel_widget
│   │   │           └── track_cards
│   │   │               └── cards
│   │   └── providers
│   ├── track
│   │   ├── backend
│   │   ├── models
│   │   │   └── typedefs
│   │   ├── notifiers
│   │   ├── presentation
│   │   │   └── widget
│   │   └── providers
│   ├── user_info
│   │   ├── backend
│   │   ├── constants
│   │   ├── models
│   │   │   └── typedefs
│   │   ├── notifiers
│   │   ├── presentation
│   │   │   └── edit_track_screen_widgets
│   │   └── providers
│   └── weather
│       ├── backend
│       │   └── api
│       ├── domain
│       │   ├── models
│       │   └── providers
│       └── presentation
│           └── view
├── firebase_providers
└── views
    ├── components
    │   ├── bottom_bar
    │   │   └── nav_states
    │   ├── constants
    │   ├── dialogs
    │   └── top_bar
    ├── login
    └── tabs
```
</div>

The project is divided into several features, each of which is contained in a separate directory. Each feature directory contains the following subdirectories:

- **backend**: Contains the code that interacts with the Firebase services.
- **constants**: Contains the constants used in the feature.
- **models**: Contains the models used in the feature.
- **notifiers**: Contains the Riverpod notifiers used in the feature.
- **presentation**: Contains the UI code for the feature.
- **providers**: Contains the Riverpod providers used in the feature.

The `common/` directory contains the code that is used across the entire application, such as the theme, the routes, and the responsive design.

The `views/` directory contains the code for the different views of the application, such as the login view and the tabs view.

The `firebase_providers/` directory contains the code that interacts with the Firebase services and provides the Riverpod providers for the entire application.

---

## 📚 Further Information

For a more detailed explanation of the project and the thought process behind it, please refer to the [project report](https://docs.google.com/document/d/14dFnmLqvft3BX01kEwfikdvIrsLHjTonX0VtNFWC6uc/edit?usp=sharing).

---

## 📝 To-Do (For those brave enough)

- [ ] Implement unit tests.
- [ ] Add a feature to allow users to upload images of tracks.
- [ ] Manage correctly the data inside the Firestore database.
- [ ] Add the ability to add and remove tracks.
- [ ] Add a calendar to show the races and opening times of the tracks.

---

## 🧠 Learned Skills

- This project has helped me understand the importance of good project management and the need to plan and organize the work to be done.
- I have learned how to use Firebase and its services, such as Firestore, Cloud Storage, and Authentication.
- I have learned how to use the OpenStreetMaps API and the Google Maps API to display maps and track locations.
- I have learned how to use Riverpod 2.0 to manage the state of the application.
- I have learned how to use Freezed to create immutable classes and reduce boilerplate code.
- I have learned how to use the Facebook Login and Google Sign-In to authenticate users.
- I have learned how to create a responsive design that works on both mobile and web platforms.
- I have learned how to use the Flutter framework (and Dart) to create a cross-platform application.

---

## 🧪 Testing

To run tests, use the following command: `flutter test` (yet to be implemented).

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
