# Nationality Predictor - Flutter App

A Flutter application that predicts nationality based on names using the [Nationalize.io](https://nationalize.io/) API.

## Features

- Enter any name to predict possible nationalities
- Shows probability percentages for each country
- Displays country flags and full country names
- Modern and responsive UI with animations
- Clean architecture with service pattern

## Screenshots

[Add screenshots here]

## Getting Started

1. Clone the repository:
```bash
git clone https://github.com/JaveedIshaq/nationality-predictor-flutter.git
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── models/
│   └── country_probability.dart
├── screens/
│   └── home_page.dart
├── services/
│   ├── country_service.dart
│   └── nationality_service.dart
├── widgets/
│   ├── prediction_card.dart
│   └── search_input_card.dart
└── main.dart
```

## Dependencies

- http: For API calls
- google_fonts: For custom typography
- flutter_animate: For smooth animations

## API Reference

This app uses the [Nationalize.io](https://nationalize.io/) API to predict nationalities based on names.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

[MIT](https://choosealicense.com/licenses/mit/)
