<div align="center">

# Crosstrack Italia

[![Flutter CI](https://github.com/MaiDormo/crosstrack_italia/actions/workflows/main.yml/badge.svg)](https://github.com/MaiDormo/crosstrack_italia/actions/workflows/main.yml)
[![Deploy](https://github.com/MaiDormo/crosstrack_italia/actions/workflows/deploy.yml/badge.svg)](https://github.com/MaiDormo/crosstrack_italia/actions/workflows/deploy.yml)

**Discover motocross tracks across Northern Italy**

[Live Demo](https://maidormo.github.io/crosstrack_italia/) · [Report Bug](https://github.com/MaiDormo/crosstrack_italia/issues)

</div>

---

## Screenshots

<div align="center">
<table>
  <tr>
    <td><img src="docs/screenshots/map_view.png" width="200" alt="Map View"/></td>
    <td><img src="docs/screenshots/track_details.png" width="200" alt="Track Details"/></td>
    <td><img src="docs/screenshots/track_list.png" width="200" alt="Track List"/></td>
  </tr>
  <tr>
    <td align="center"><b>Map View</b></td>
    <td align="center"><b>Track Details</b></td>
    <td align="center"><b>Track List</b></td>
  </tr>
</table>
</div>

---

## Features

- **Interactive Map** — Browse tracks with OpenStreetMap integration
- **Track Details** — View info, location, terrain type, and user reviews
- **Search & Filter** — Find tracks by name, region, or category
- **Reviews & Ratings** — Leave feedback on tracks you've visited
- **Favorites** — Save tracks for quick access
- **Weather** — Real-time weather for each track location
- **Track Management** — Owners can edit their track information
- **Cross-platform** — Works on Android, iOS, and Web

---

## Tech Stack

| Category | Technologies |
|----------|-------------|
| Framework | Flutter 3.38+, Dart 3.10+ |
| State | Riverpod 3.x, Freezed 3.x |
| Backend | Firebase (Auth, Firestore, Storage) |
| Maps | flutter_map, OpenStreetMap |
| Auth | Google Sign-In, Facebook Login |

---

## Quick Start

```bash
# Clone and install
git clone https://github.com/MaiDormo/crosstrack_italia.git
cd crosstrack_italia
flutter pub get

# Generate code (Freezed/Riverpod)
dart run build_runner build -d

# Run
flutter run --dart-define=OPENWEATHER_API_KEY=your_key
```

> Get a free API key at [OpenWeatherMap](https://openweathermap.org/api)

---

## Project Structure

```
lib/
├── features/
│   ├── auth/          # Authentication
│   ├── map/           # Map display & markers
│   ├── track/         # Track data & UI
│   ├── user_info/     # User profiles & favorites
│   └── weather/       # Weather integration
├── views/             # Main screens & components
└── main.dart          # App entry point
```

---

## Roadmap

- [x] Core map and track browsing
- [x] User authentication
- [x] Reviews and ratings
- [x] Web support
- [ ] Track image uploads
- [ ] Event calendar
- [ ] Push notifications

---

## License

MIT License — see [LICENSE](LICENSE) for details.
