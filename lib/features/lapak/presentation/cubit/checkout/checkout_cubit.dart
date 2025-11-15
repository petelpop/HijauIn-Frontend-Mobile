import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/models/checkout.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/services/services.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final LapakServices _services;

  CheckoutCubit(this._services) : super(CheckoutInitial());

  Future<void> checkout({
    required String recipientName,
    required String phoneNumber,
    required String address,
    required String city,
    required String province,
    required String postalCode,
    String? notes,
  }) async {
    try {
      emit(CheckoutLoading());

      final requestBody = {
        'recipientName': recipientName,
        'phoneNumber': phoneNumber,
        'address': address,
        'city': city,
        'province': province,
        'postalCode': postalCode,
        if (notes != null && notes.isNotEmpty) 'notes': notes,
      };

      final response = await _services.checkout(requestBody);
      emit(CheckoutSuccess(checkoutData: response));
    } catch (e) {
      emit(CheckoutError(message: e.toString()));
    }
  }

  Future<void> checkPaymentStatus(String transactionId) async {
    try {
      emit(CheckoutLoading());

      final response = await _services.checkPaymentStatus(transactionId);
      emit(PaymentStatusChecked(checkoutData: response));
    } catch (e) {
      emit(CheckoutError(message: e.toString()));
    }
  }
}
