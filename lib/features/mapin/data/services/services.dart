import 'package:hijauin_frontend_mobile/endpoint/endpoints.dart';
import 'package:hijauin_frontend_mobile/features/mapin/data/models/waste_location_model.dart';
import 'package:hijauin_frontend_mobile/utils/dio_client.dart';

class MapinServices {
  final DioClient _dioClient = DioClient();
  
  Future<WasteLocation> getWasteLocations(double lat, double lng) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoint.wasteLocationsNearby(lat, lng),
      );
      return WasteLocation.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<WasteLocation> getWasteLocationsByCategory(
    double lat,
    double lng,
    List<String> categories,
  ) async {
    try {
      final categoriesString = categories.join(',');
      final response = await _dioClient.get(
        ApiEndpoint.wasteLocationsNearbyWithCategory(lat, lng, categoriesString),
      );
      return WasteLocation.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}