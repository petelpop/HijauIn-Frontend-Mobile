part of 'detail_lapak_cubit.dart';

sealed class DetailLapakState extends Equatable {
  const DetailLapakState();

  @override
  List<Object> get props => [];
}

final class DetailLapakInitial extends DetailLapakState {}

final class DetailLapakLoading extends DetailLapakState {}

final class DetailLapakLoaded extends DetailLapakState {
  final DetailLapak product;

  const DetailLapakLoaded(this.product);

  @override
  List<Object> get props => [product];
}

final class DetailLapakError extends DetailLapakState {
  final String message;

  const DetailLapakError(this.message);

  @override
  List<Object> get props => [message];
}
