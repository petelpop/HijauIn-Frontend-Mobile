import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoint {
  static String baseUrl = dotenv.env['BASE_URL'].toString();
  static String aqiBaseUrl = dotenv.env['AQI_BASE_URL'].toString();
  static String aqiToken = dotenv.env['AQI_TOKEN'].toString();

  // Auth Endpoints
  static String register = '$baseUrl/auth/register';
  static String login = '$baseUrl/auth/login';
  static String forgotPassword = '$baseUrl/auth/forgot-password';

  // Home Endpoints
  static String aqiHomeWidget(lat, long) => '$aqiBaseUrl/feed/geo:$lat;$long/?token=$aqiToken';
}