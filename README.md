# 🎬 Streamly

Streamly is a Flutter-based movie and TV show browsing application powered by **The Movie Database (TMDB) API**.  
It allows users to explore popular, top-rated, now-playing movies, and trending TV shows with a smooth, modern UI.

---

## ✨ Features

- 🔥 Popular & Top-Rated Movies
- 🎥 Now Playing Movies
- 📺 Popular & Recommended TV Shows
- 🔍 Search Movies & TV Shows
- 🎞️ Watch Trailers (YouTube)
- 📱 Smooth scrolling UI with animated bottom navigation
- ⚡ Fast networking using **Dio**
- 🧱 Clean architecture with Models & Services separation

---

## 🛠 Tech Stack

- **Flutter**
- **Dart**
- **Dio** (HTTP client)
- **TMDB API**
- Material Design

---

📂 **Project Structure**

Streamly/
├── android/                     # Android-specific native configuration
├── ios/                         # iOS-specific native configuration
├── linux/                       # Linux desktop support
├── macos/                       # macOS desktop support
├── web/                         # Web support files
├── assets/                      # Images, icons, animations (Lottie, PNG, JPG)
├── lib/                         # Main application source code
│   ├── Models/                  # Data models (Movies, TV Shows, Episodes, etc.)
│   ├── Screens/                 # UI screens (Login, Home, Movie, TV Show, Profile)
│   ├── Services/                # API calls, authentication, helpers
│   ├── Widgets/                 # Reusable UI components
│   ├── routes.dart              # App navigation routes
│   ├── firebase_options.dart    # Firebase configuration
│   └── main.dart                # App entry point
├── test/                        # Widget and unit tests
├── pubspec.yaml                  # Project dependencies & assets configuration
├── pubspec.lock                  # Locked dependency versions
├── README.md                     # Project documentation
└── .gitignore                    # Files ignored by Git


## 📸 Screenshots

<table>
  <tr>
    <td align="center">
      🔐 Login Screen<br>
      <img src="screenshots/WhatsApp%20Image%202025-12-29%20at%2009.50.25.jpeg" alt="Login" width="200"/>
    </td>
    <td align="center">
      🏠 Home Screen<br>
      <img src="screenshots/WhatsApp%20Image%202025-12-29%20at%2009.50.25%20(2).jpeg" alt="Home" width="200"/>
    </td>
    <td align="center">
      🎬 Movie Details<br>
      <img src="screenshots/WhatsApp%20Image%202025-12-29%20at%2009.50.25%20(3).jpeg" alt="Movie" width="200"/>
    </td>
    <td align="center">
      📺 TV Show Details<br>
      <img src="screenshots/WhatsApp%20Image%202025-12-29%20at%2009.50.25%20(4).jpeg" alt="TV Show" width="200"/>
    </td>
  </tr>
</table>







