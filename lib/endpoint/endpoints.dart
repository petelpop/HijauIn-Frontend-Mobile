import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoint {
  static String baseUrl = dotenv.env['BASE_URL'].toString();
  static String aqiBaseUrl = dotenv.env['AQI_BASE_URL'].toString();
  static String aqiToken = dotenv.env['AQI_TOKEN'].toString();

  // Auth Endpoints
  static String register = '$baseUrl/auth/register';
  static String login = '$baseUrl/auth/login';
  static String forgotPassword = '$baseUrl/auth/forgot-password';
  static String logout = '$baseUrl/auth/logout';

  // Home Endpoints
  static String aqiHomeWidget(lat, long) => '$aqiBaseUrl/feed/geo:$lat;$long/?token=$aqiToken';

  // Mapin Endpoints
  static String wasteLocationsNearby(lat, long) => '$baseUrl/loka/nearby?lat=$lat&lng=$long&radius=1500';
  static String wasteLocationsNearbyWithCategory(lat, long,categories) => '$baseUrl/loka/nearby?lat=$lat&lng=$long&radius=1500&categories=$categories';

  static String aqicnMapsUrl(String? lat, String? lng, String? lat2, String? lng2, String token) => "$aqiBaseUrl/v2/map/bounds?latlng=$lat,$lng,$lat2,$lng2&networks=all&token=$token";

  // Warta Endpoints
  static String listArticles(String? search, int? page, int? limit) => '$baseUrl/public/articles?search=$search&page=$page&limit=$limit';
  static String articleDetail(String slug) => '$baseUrl/public/articles/$slug';

  // Lapak Endpoints
  static String listProducts = "$baseUrl/products";
  static String searchListProducts(String query) => '$baseUrl/products?search=$query';
  static String getAllCategories = "$baseUrl/product-categories";
  static String getProductsByCategory(String category) => '$baseUrl//products?category=$category';
  static String productDetail(String id) => '$baseUrl/products/$id';

}