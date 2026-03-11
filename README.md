# Bali Halal Way

A SwiftUI iOS app that displays a map of Bali showing nearby halal restaurants using MapKit.

## Features

- 🗺️ Interactive map centered on Bali / Sanur area
- 📍 Custom orange pin annotations with floating restaurant info cards
- 🍽️ Shows 4 halal restaurants: Halaiku Restaurant, Warung Halal Bali, Ubud Halal Taste, Kuta Halal Bites
- 🏛️ Points of interest: SPBU Pertamina, Museum Le Mayeur, Icon Bali Mall, Artasedana Sanur, Prama Sanur Beach Bali
- 🔀 Navigation / Detail Route segmented control at the top

## Requirements

- Xcode 15+
- iOS 17.0+
- Swift 5.9+

## Project Structure

```
BaliHalalWay/
├── BaliHalalWay.xcodeproj/         # Xcode project file
└── BaliHalalWay/
    ├── BaliHalalWayApp.swift        # App entry point
    ├── ContentView.swift            # Root content view
    ├── Models/
    │   └── Restaurant.swift         # Restaurant data model
    ├── Views/
    │   ├── NavigationMapView.swift  # Main map view with top tab bar
    │   └── RestaurantAnnotationView.swift  # Custom map annotation card
    ├── Assets.xcassets/             # Asset catalog
    └── Preview Content/             # Xcode preview assets
```

## Getting Started

1. Open `BaliHalalWay/BaliHalalWay.xcodeproj` in Xcode
2. Select an iPhone 15 simulator (iOS 17+)
3. Build and run (⌘R)