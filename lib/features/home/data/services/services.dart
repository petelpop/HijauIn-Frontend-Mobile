import 'package:hijauin_frontend_mobile/endpoint/endpoints.dart';
import 'package:hijauin_frontend_mobile/features/home/data/models/aqi_home_model.dart';
import 'package:hijauin_frontend_mobile/utils/dio_client.dart';

class HomeServices {
  final DioClient _dioClient = DioClient();

  Future<AqiHomeData> getAqiData(double lat, double long) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoint.aqiHomeWidget(lat, long),
      );
      return AqiHomeData.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
