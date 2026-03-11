# Bali Halal Way

A SwiftUI iOS app that displays a map of Bali showing nearby halal restaurants using MapKit.

## Features

- 🗺️ Interactive map centered on Bali / Sanur area
- 📍 Custom orange pin annotations with floating restaurant info cards
- 🍽️ Shows 4 halal restaurants: Halaiku Restaurant, Warung Halal Bali, Ubud Halal Taste, Kuta Halal Bites
- 🏛️ Points of interest: SPBU Pertamina, Museum Le Mayeur, Icon Bali Mall, Artasedana Sanur, Prama Sanur Beach Bali
- 🔀 Navigation / Detail Route segmented control at the top
- 🖼️ Support for custom restaurant images with SF Symbol fallback

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
    │   ├── DetailRouteView.swift    # Scrollable restaurant card list
    │   └── RestaurantAnnotationView.swift  # Custom map annotation card
    ├── Assets.xcassets/             # Asset catalog (images go here)
    │   ├── halalku_restaurant.imageset/
    │   ├── warung_halal_bali.imageset/
    │   ├── canggu_halal_kitchen.imageset/
    │   └── denpasar_halal_food.imageset/
    └── Preview Content/             # Xcode preview assets
```

## Getting Started

1. Open `BaliHalalWay/BaliHalalWay.xcodeproj` in Xcode
2. Select an iPhone 15 simulator (iOS 17+)
3. Build and run (⌘R)

## Cara Menambahkan Gambar Restoran (How to Add Restaurant Images)

Setiap restoran sudah memiliki _image set_ di dalam `Assets.xcassets`. Kamu cukup memasukkan file gambar ke dalamnya.

### Langkah-langkah lewat Xcode

1. Buka project di **Xcode** (`BaliHalalWay.xcodeproj`).
2. Di panel kiri (Project Navigator), buka **Assets.xcassets**.
3. Pilih salah satu _image set_ restoran, misalnya `halalku_restaurant`.
4. **Drag & drop** file gambar (`.png` atau `.jpg`) ke slot yang tersedia:
   - **1x** — ukuran standar (misal 120×120 px)
   - **2x** — resolusi retina (misal 240×240 px)
   - **3x** — resolusi super retina (misal 360×360 px)
5. Ulangi untuk _image set_ restoran lainnya:
   - `warung_halal_bali`
   - `canggu_halal_kitchen`
   - `denpasar_halal_food`
6. Build dan run (⌘R) — gambar akan otomatis muncul di kartu restoran dan di peta.

> **Tips:** Kalau kamu hanya punya satu ukuran gambar, taruh di slot **2x** saja sudah cukup.

### Menambahkan restoran baru dengan gambar

1. Buat _image set_ baru di `Assets.xcassets`:
   - Klik kanan → **New Image Set** → beri nama (contoh: `restoran_baru`).
   - Drag & drop gambar ke slot 1x/2x/3x.
2. Tambahkan data restoran baru di `Models/Restaurant.swift`:
   ```swift
   Restaurant(
       name: "Nama Restoran Baru",
       description: "Deskripsi restoran.",
       distance: "2.0 km",
       coordinate: CLLocationCoordinate2D(latitude: -8.6800, longitude: 115.2200),
       imagePlaceholderColor: "orange",
       imageName: "restoran_baru"  // nama image set yang kamu buat
   )
   ```
3. Build dan run — restoran baru akan muncul di peta dan daftar, lengkap dengan gambarnya.

> Jika _image set_ belum diisi gambar, aplikasi akan otomatis menampilkan ikon placeholder (SF Symbol).