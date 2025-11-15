part of 'checkout_cubit.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutSuccess extends CheckoutState {
  final CheckoutData checkoutData;

  const CheckoutSuccess({required this.checkoutData});

  @override
  List<Object> get props => [checkoutData];
}

class CheckoutError extends CheckoutState {
  final String message;

  const CheckoutError({required this.message});

  @override
  List<Object> get props => [message];
}

class PaymentStatusChecked extends CheckoutState {
  final CheckoutData checkoutData;

  const PaymentStatusChecked({required this.checkoutData});

  @override
  List<Object> get props => [checkoutData];
}
