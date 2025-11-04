import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hijauin_frontend_mobile/endpoint/endpoints.dart';
import 'package:hijauin_frontend_mobile/endpoint/type_defs.dart';
import 'package:hijauin_frontend_mobile/features/auth/data/models/register.dart';
import 'package:hijauin_frontend_mobile/utils/dio_client.dart';
import 'package:hijauin_frontend_mobile/utils/exception.dart';

class AuthServices {
  final _dio = DioClient();

  FutureEither<void> register(RegisterData payload) async {
    try {
      final response = await _dio.post(ApiEndpoint.register, body: payload.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(null);
      }

      final message = response.data is Map && response.data['message'] != null
          ? response.data['message'].toString()
          : 'Register failed';

      return left(ApiException(message: message, responseCode: true));
    } on DioError catch (e) {
      String message = e.message ?? e.toString();
      if (e.response != null && e.response?.data != null) {
        try {
          if (e.response?.data is Map && e.response?.data['message'] != null) {
            message = e.response?.data['message'].toString() ?? message;
          }
        } catch (_) {}
      }
      return left(ApiException(message: message));
    } catch (e) {
      return left(ApiException(message: e.toString()));
    }
  }
}