# Hijauin - Aplikasi Pengelolaan Sampah dan Lingkungan 🌍🌿

<div align="center">
  
  [![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)](https://flutter.dev/)
  [![Dart](https://img.shields.io/badge/Dart-3.0+-blue.svg)](https://dart.dev/)
</div>

## 📱 Download Aplikasi

| Platform | Link Download | Status |
|----------|--------------|--------|
| 🤖 Android APK | [Download APK](https://drive.google.com/file/d/1AszCFIWfrb8XTfTKvnsERAl9imiW5kas/view?usp=sharing) | ✅ Available |
| 🍎 iOS | Coming Soon |

> **Catatan**: Untuk instalasi APK di Android, pastikan Anda mengizinkan instalasi dari sumber tidak dikenal di pengaturan perangkat.

## 📖 Tentang Aplikasi

**Hijauin** adalah aplikasi mobile berbasis Flutter yang dirancang untuk membantu masyarakat dalam pengelolaan sampah dan monitoring kualitas lingkungan. Aplikasi ini menyediakan berbagai fitur untuk mendukung gaya hidup ramah lingkungan.

## ✨ Fitur Utama

### 🏠 Home
- Dashboard utama dengan akses cepat ke semua fitur
- Informasi cuaca dan kualitas udara
- Berita dan artikel lingkungan terkini

### 🗺️ MapIn (Peta Interaktif)
- **Tempat Sampah**: Lokasi tempat pembuangan sampah terdekat
- **Kualitas Udara**: Monitoring kualitas udara real-time
- Informasi detail setiap lokasi

### 🗑️ Sortir (Pemilahan Sampah)
- Panduan pemilahan sampah:
  - Sampah Organik
  - Sampah Anorganik
  - Sampah B3 (Bahan Berbahaya dan Beracun)
- Peta lokasi tempat sampah berdasarkan kategori
- Informasi jarak dan navigasi

### 🛒 Lapak (Marketplace)
- Belanja produk ramah lingkungan
- Keranjang belanja
- Checkout dan pembayaran (integrasi Midtrans)

### 📰 Warta (Artikel & Berita)
- Artikel edukatif tentang lingkungan

### 💬 AskFlo (Chatbot AI)
- Asisten virtual untuk pertanyaan seputar lingkungan
- Chat interaktif

## 🛠️ Teknologi yang Digunakan

### Frontend
- **Flutter** - Framework UI cross-platform
- **Dart** - Bahasa pemrograman
- **Cubit** - State management
- **Go Router** - Navigasi deklaratif
- **Dio** - HTTP client
- **Sizer** - Responsive design

### Peta & Lokasi
- **flutter_map** - Peta interaktif
- **latlong2** - Koordinat geografis
- **geolocator** - Layanan lokasi
- **OpenStreetMap** - Tile provider

### Payment & WebView
- **Midtrans** - Payment gateway
- **webview_flutter** - WebView untuk pembayaran

### UI/UX
- **cached_network_image** - Caching gambar
- **shimmer** - Loading placeholder
- **intl** - Internasionalisasi

### Storage & Data
- **shared_preferences** - Local storage
- **path_provider** - Akses file system

## 📁 Struktur Folder

```
lib/
├── common/                 # Komponen UI umum
│   ├── auth_form.dart
│   ├── colors.dart
│   ├── constants.dart
│   ├── primary_button.dart
│   └── primary_text.dart
├── endpoint/              # Konfigurasi API
│   ├── endpoints.dart
│   └── type_defs.dart
├── features/              # Fitur aplikasi
│   ├── askflo/           # Chatbot AI
│   ├── auth/             # Autentikasi
│   ├── home/             # Halaman utama
│   ├── lapak/            # Marketplace
│   ├── main/             # Main navigation
│   ├── mapin/            # Peta interaktif
│   ├── onboarding/       # Onboarding
│   ├── sortir/           # Pemilahan sampah
│   ├── splash/           # Splash screen
│   └── warta/            # Artikel & berita
├── utils/                # Utilities
│   ├── dio_client.dart
│   ├── distance_calculator.dart
│   ├── exception.dart
│   ├── location_service.dart
│   ├── logger_service.dart
│   ├── modal_bottom.dart
│   ├── modal_topbar.dart
│   ├── route.dart
│   ├── shared_storage.dart
│   ├── shimmer_card.dart
│   └── toast_widget.dart
└── main.dart             # Entry point
```

## 🎨 Design Pattern

Aplikasi ini menggunakan **Cubit Pattern** untuk state management dengan struktur:

```
feature/
├── data/
│   ├── models/          # Data models
│   └── services/        # API services
├── presentation/
│   ├── components/      # UI components
│   ├── cubit/          # Cubit
│   └── views/          # Pages/Screens
```

## 🔐 Autentikasi

Aplikasi menggunakan JWT (JSON Web Token) untuk autentikasi:
- Token disimpan di SharedPreferences
- Auto-refresh token
- Session management

## 👥 Tim Pengembang

- **Frontend**: [petelpop](https://github.com/petelpop)
- **Backend**: [Afasarya](https://github.com/Afasarya)
- **UI/UX**: [hanifacode](https://github.com/hanifacode)

## 📞 Kontak & Support

*   **Gmail**: [m.naufal.s.k@gmail.com](https://mail.google.com/mail/?view=cm&fs=1&to=m.naufal.s.k@gmail.com)

---

<div align="center">
  
  **Hijauin** - Bersama Menuju Lingkungan Lebih Hijau 🌱
</div>
