import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoint {
  static String baseUrl = dotenv.env['BASE_URL'].toString();

  // Auth Endpoints
  static String register = '$baseUrl/auth/register';
}