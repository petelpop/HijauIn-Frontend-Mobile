part of 'lapak_main_cubit.dart';

sealed class LapakMainState extends Equatable {
  const LapakMainState();

  @override
  List<Object> get props => [];
}

final class LapakMainInitial extends LapakMainState {}

final class LapakMainLoading extends LapakMainState {}

final class LapakMainLoaded extends LapakMainState {
  final List<Datum> products;
  final Meta meta;

  const LapakMainLoaded({
    required this.products,
    required this.meta,
  });

  @override
  List<Object> get props => [products, meta];
}

final class LapakMainError extends LapakMainState {
  final String message;

  const LapakMainError(this.message);

  @override
  List<Object> get props => [message];
}
