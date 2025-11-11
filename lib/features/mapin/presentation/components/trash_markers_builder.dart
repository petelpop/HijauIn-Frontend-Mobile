import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/features/mapin/data/models/waste_location_model.dart';
import 'package:latlong2/latlong.dart';

class TrashMarkersBuilder {
  static List<Marker> buildMarkers({
    required List<WasteLocationDataModel> locations,
    required Function(WasteLocationDataModel) onMarkerTap,
  }) {
    return locations.map((location) {
      return Marker(
        point: LatLng(
          location.coordinates.latitude,
          location.coordinates.longitude,
        ),
        width: 40,
        height: 40,
        child: GestureDetector(
          onTap: () => onMarkerTap(location),
          child: Icon(
            Icons.location_on,
            size: 40,
            color: primaryColor600,
          ),
        ),
      );
    }).toList();
  }
}
