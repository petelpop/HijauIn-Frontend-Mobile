import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/models/list_cart.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/models/update_cart_request.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/services/services.dart';
import 'package:hijauin_frontend_mobile/utils/logger_service.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final LapakServices _services;

  CartCubit(this._services) : super(CartInitial());

  Future<void> fetchCart() async {
    try {
      emit(CartLoading());
      final cart = await _services.getCart();
      emit(CartLoaded(cart));
    } catch (e) {
      LoggerService.error('Error in CartCubit: $e');
      emit(CartError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> updateCartItem(String itemId, int quantity) async {
    try {
      if (quantity <= 0) {
        await _services.deleteCartItem(itemId);
      } else {
        final request = UpdateCartRequest(quantity: quantity);
        await _services.updateCart(itemId, request);
      }
      await fetchCart();
    } catch (e) {
      LoggerService.error('Error updating cart item: $e');
      await fetchCart();
    }
  }
}
