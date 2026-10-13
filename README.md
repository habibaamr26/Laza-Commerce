# Laza Commerce
An e-commerce app in Flutter, built so far around the authentication flow. Users can register and log in against a REST API, and the app stores the tokens securely and refreshes the access token when a request returns 401.

## Features
- Register and login screens with form validation
- Success and error dialogs for API responses
- Access and refresh tokens saved with flutter_secure_storage
- Dio interceptor that catches 401 responses, refreshes the token once (parallel requests wait for the same refresh) and retries the original request
- Typed API result (success / error) with a central error handler
- Request and response logging with pretty_dio_logger

## Tech stack
- Flutter, Dart
- State management: flutter_bloc (Cubit)
- Networking: dio, retrofit, json_serializable, pretty_dio_logger
- Storage: flutter_secure_storage, shared_preferences
- Dependency injection: get_it

## Project structure
```
lib/
├── core/
│   ├── di/           get_it setup
│   ├── networking/   Dio factory, token refresh interceptor, API constants, error handling
│   ├── helper/       secure storage and shared preferences helper
│   ├── storage/      caching interface
│   ├── routs/        route names and route generator
│   ├── widgets/      shared buttons, text fields and dialogs
│   └── constants/    colors and text styles
├── features/
│   ├── login/        login API, token storage, cubit and UI
│   ├── register/     register API, cubit and UI
│   └── main/         screen shown after login
└── main.dart
```

## Getting started
```
flutter pub get
flutter run
```
