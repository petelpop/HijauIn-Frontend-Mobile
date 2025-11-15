import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hijauin_frontend_mobile/features/auth/presentation/views/login_page.dart';
import 'package:hijauin_frontend_mobile/utils/shared_storage.dart';
import 'package:hijauin_frontend_mobile/utils/toast_widget.dart';
import 'logger_service.dart';

class DioClient {
  final Dio _dio = Dio();
  static BuildContext? _appContext;

  static void setContext(BuildContext context) {
    _appContext = context;
  }

  DioClient() {
    _dio.options.connectTimeout = Duration(milliseconds: 10000);
    _dio.options.receiveTimeout = Duration(milliseconds: 10000);
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await SharedStorage.getAccessToken();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
          LoggerService.log('Authorization header added: Bearer ${token.substring(0, 20)}...');
        }
        
        LoggerService.log('Request: ${options.method} ${options.uri}');
        LoggerService.log('Headers: ${options.headers}');
        LoggerService.log('Query Parameters: ${options.queryParameters}');
        LoggerService.log('Request Body: ${options.data}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        LoggerService.log('Response: ${response.statusCode} ${response.data}');
        return handler.next(response);
      },
      onError: (DioException e, handler) async {
        LoggerService.error('Error: ${e.message}');
        LoggerService.error('Error Response: ${e.response?.data}');
        
        if (e.response?.statusCode == 401) {
          LoggerService.error('Unauthorized! Session expired.');
          
          await SharedStorage.clearAuthData();
          
          if (_appContext != null && _appContext!.mounted) {
            ToastWidget.showToast(
              _appContext!,
              message: "Sesi telah berakhir, silahkan login ulang",
              color: Color(0xFFF44336),
              duration: Duration(seconds: 3),
            );
            
            _appContext!.goNamed(LoginPage.routeName);
          }
        }
        
        return handler.next(e);
      },
    ));
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters, dynamic body}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters, data: body);
      return response;
    } catch (e) {
      LoggerService.error('GET request failed: $e');
      rethrow;
    }
  }

  Future<Response> post(String path, {Map<String, dynamic>? queryParameters, dynamic body}) async {
    try {
      final response = await _dio.post(path, queryParameters: queryParameters, data: body);
      return response;
    } catch (e) {
      LoggerService.error('POST request failed: $e');
      rethrow;
    }
  }

  Future<Response> put(String path, {Map<String, dynamic>? queryParameters, dynamic body}) async {
    try {
      final response = await _dio.put(path, queryParameters: queryParameters, data: body);
      return response;
    } catch (e) {
      LoggerService.error('PUT request failed: $e');
      rethrow;
    }
  }

  Future<Response> delete(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.delete(path, queryParameters: queryParameters);
      return response;
    } catch (e) {
      LoggerService.error('DELETE request failed: $e');
      rethrow;
    }
  }
}
