import 'package:dio/dio.dart';
import 'package:hijauin_frontend_mobile/endpoint/endpoints.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/models/add_to_cart_request.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/models/detail_lapak.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/models/list_categories.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/models/list_lapak.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/models/list_cart.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/models/update_cart_request.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/models/checkout.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/models/history.dart';
import 'package:hijauin_frontend_mobile/utils/dio_client.dart';
import 'package:hijauin_frontend_mobile/utils/logger_service.dart';

class LapakServices {
  final _dio = DioClient();


  Future<Listlapak> getAllProducts() async {
    try {
      final response = await _dio.get(ApiEndpoint.listProducts);
      LoggerService.info('Products fetched successfully');
      return Listlapak.fromJson(response.data);
    } on DioException catch (e) {
      LoggerService.error('Error fetching products: ${e.message}');
      throw Exception('Failed to fetch products: ${e.message}');
    }
  }

  Future<Listlapak> searchProducts(String query) async {
    try {
      final response = await _dio.get(ApiEndpoint.searchListProducts(query));
      LoggerService.info('Products searched successfully for: $query');
      return Listlapak.fromJson(response.data);
    } on DioException catch (e) {
      LoggerService.error('Error searching products: ${e.message}');
      throw Exception('Failed to search products: ${e.message}');
    }
  }

  Future<ListCategories> getAllCategories() async {
    try {
      final response = await _dio.get(ApiEndpoint.getAllCategories);
      LoggerService.info('Categories fetched successfully');
      return ListCategories.fromJson(response.data);
    } on DioException catch (e) {
      LoggerService.error('Error fetching categories: ${e.message}');
      throw Exception('Failed to fetch categories: ${e.message}');
    }
  }

  Future<Listlapak> getProductsByCategory(String categoryId) async {
    try {
      final response = await _dio.get(ApiEndpoint.getProductsByCategory(categoryId));
      LoggerService.info('Products by category fetched successfully');
      return Listlapak.fromJson(response.data);
    } on DioException catch (e) {
      LoggerService.error('Error fetching products by category: ${e.message}');
      throw Exception('Failed to fetch products by category: ${e.message}');
    }
  }

  Future<DetailLapak> getProductDetail(String productId) async {
    try {
      final response = await _dio.get(ApiEndpoint.productDetail(productId));
      LoggerService.info('Product detail fetched successfully for ID: $productId');
      return DetailLapak.fromJson(response.data);
    } on DioException catch (e) {
      LoggerService.error('Error fetching product detail: ${e.message}');
      throw Exception('Failed to fetch product detail: ${e.message}');
    }
  }

  Future<Map<String, dynamic>> addToCart(AddToCartRequest request) async {
    try {
      final response = await _dio.post(
        ApiEndpoint.addToCart,
        body: request.toJson(),
      );
      LoggerService.info('Product added to cart successfully: ${request.productId}');
      return response.data;
    } on DioException catch (e) {
      LoggerService.error('Error adding to cart: ${e.message}');
      LoggerService.error('Error response: ${e.response?.data}');
      
      if (e.response?.data != null && e.response?.data is Map) {
        final errorMessage = e.response?.data['message'] ?? 'Failed to add to cart';
        throw Exception(errorMessage);
      }
      
      throw Exception('Failed to add to cart: ${e.message}');
    }
  }

  Future<ListCart> getCart() async {
    try {
      final response = await _dio.get(ApiEndpoint.getCart);
      LoggerService.info('Cart fetched successfully');
      return ListCart.fromJson(response.data);
    } on DioException catch (e) {
      LoggerService.error('Error fetching cart: ${e.message}');
      throw Exception('Failed to fetch cart: ${e.message}');
    }
  }

  Future<Map<String, dynamic>> updateCart(String itemId, UpdateCartRequest request) async {
    try {
      final response = await _dio.patch(
        ApiEndpoint.updateCart(itemId),
        body: request.toJson(),
      );
      LoggerService.info('Cart item updated successfully: $itemId with quantity ${request.quantity}');
      return response.data;
    } on DioException catch (e) {
      LoggerService.error('Error updating cart: ${e.message}');
      LoggerService.error('Error response: ${e.response?.data}');
      
      if (e.response?.data != null && e.response?.data is Map) {
        final errorMessage = e.response?.data['message'] ?? 'Failed to update cart';
        throw Exception(errorMessage);
      }
      
      throw Exception('Failed to update cart: ${e.message}');
    }
  }

  Future<Map<String, dynamic>> deleteCartItem(String itemId) async {
    try {
      final response = await _dio.delete(ApiEndpoint.deleteCartItem(itemId));
      LoggerService.info('Cart item deleted successfully: $itemId');
      return response.data;
    } on DioException catch (e) {
      LoggerService.error('Error deleting cart item: ${e.message}');
      LoggerService.error('Error response: ${e.response?.data}');
      
      if (e.response?.data != null && e.response?.data is Map) {
        final errorMessage = e.response?.data['message'] ?? 'Failed to delete cart item';
        throw Exception(errorMessage);
      }
      
      throw Exception('Failed to delete cart item: ${e.message}');
    }
  }

  Future<CheckoutData> checkout(Map<String, dynamic> requestBody) async {
    try {
      final response = await _dio.post(
        ApiEndpoint.checkout,
        body: requestBody,
      );
      LoggerService.info('Checkout successful');
      return CheckoutData.fromJson(response.data);
    } on DioException catch (e) {
      LoggerService.error('Error during checkout: ${e.message}');
      LoggerService.error('Error response: ${e.response?.data}');
      
      if (e.response?.data != null && e.response?.data is Map) {
        final errorMessage = e.response?.data['message'] ?? 'Failed to checkout';
        throw Exception(errorMessage);
      }
      
      throw Exception('Failed to checkout: ${e.message}');
    }
  }

  Future<CheckoutData> checkPaymentStatus(String transactionId) async {
    try {
      final response = await _dio.get(ApiEndpoint.checkPaymentStatus(transactionId));
      LoggerService.info('Payment status checked successfully for transaction: $transactionId');
      return CheckoutData.fromJson(response.data);
    } on DioException catch (e) {
      LoggerService.error('Error checking payment status: ${e.message}');
      LoggerService.error('Error response: ${e.response?.data}');
      
      if (e.response?.data != null && e.response?.data is Map) {
        final errorMessage = e.response?.data['message'] ?? 'Failed to check payment status';
        throw Exception(errorMessage);
      }
      
      throw Exception('Failed to check payment status: ${e.message}');
    }
  }

  Future<HistoryData> getHistory() async {
    try {
      final response = await _dio.get(ApiEndpoint.getHistory);
      LoggerService.info('Transaction history fetched successfully');
      return HistoryData.fromJson(response.data);
    } on DioException catch (e) {
      LoggerService.error('Error fetching history: ${e.message}');
      LoggerService.error('Error response: ${e.response?.data}');
      
      if (e.response?.data != null && e.response?.data is Map) {
        final errorMessage = e.response?.data['message'] ?? 'Failed to fetch history';
        throw Exception(errorMessage);
      }
      
      throw Exception('Failed to fetch history: ${e.message}');
    }
  }
}
