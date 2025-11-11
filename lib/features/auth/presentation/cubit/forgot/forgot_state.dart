part of 'forgot_cubit.dart';

sealed class ForgotState extends Equatable {
  const ForgotState();

  @override
  List<Object> get props => [];
}

final class ForgotInitial extends ForgotState {}

final class ForgotLoading extends ForgotState {}

final class ForgotFailed extends ForgotState {
  final String message;

  const ForgotFailed({required this.message});

  @override
  List<Object> get props => [message];
}

final class ForgotSuccess extends ForgotState {
  final String message;

  const ForgotSuccess({required this.message});

  @override
  List<Object> get props => [message];
}