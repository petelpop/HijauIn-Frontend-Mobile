import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/features/mapin/data/models/aqi_location_model.dart';
import 'package:latlong2/latlong.dart';

class AqiMarkersBuilder {
  static List<Marker> buildMarkers({
    required List<AqiLokaDataModel> locations,
    required Function(AqiLokaDataModel) onMarkerTap,
  }) {
    return locations.map((location) {
      int aqiValue = int.tryParse(location.aqi ?? '0') ?? 0;
      Color markerColor = _getAqiColor(aqiValue);

      return Marker(
        point: LatLng(location.lat ?? 0, location.lon ?? 0),
        width: 60,
        height: 40,
        child: GestureDetector(
          onTap: () => onMarkerTap(location),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: markerColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '${location.aqi ?? '0'}',
                style: TextStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  static Color _getAqiColor(int aqiValue) {
    if (aqiValue <= 50) {
      return Color(0xFF10B981); 
    } else if (aqiValue <= 100) {
      return Color(0xFFFBBF24); 
    } else if (aqiValue <= 150) {
      return Color(0xFFFC7600); 
    } else if (aqiValue <= 200) {
      return Color(0xFFD65519); 
    } else if (aqiValue <= 300) {
      return Color(0xFFC12CE2);
    } else {
      return Color(0xFF4F2659);
    }
  }
}
