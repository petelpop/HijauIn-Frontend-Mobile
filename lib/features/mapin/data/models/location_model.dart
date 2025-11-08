class TrashLocation {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final String description;
  final String? imageUrl;
  final List<String> types; // Organik, Anorganik, B3
  final double distance; // dalam meter

  TrashLocation({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.description,
    this.imageUrl,
    required this.types,
    required this.distance,
  });
}

class AirQualityLocation {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final int aqiValue;
  final String quality; // Baik, Sedang, Tidak Sehat, dll
  final String message;

  AirQualityLocation({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.aqiValue,
    required this.quality,
    required this.message,
  });
}
