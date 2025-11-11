part of 'waste_cubit.dart';

sealed class WasteState extends Equatable {
  const WasteState();

  @override
  List<Object> get props => [];
}

final class WasteInitial extends WasteState {}

final class WasteLoading extends WasteState {}

final class WasteLoaded extends WasteState {
  final WasteLocation wasteLocation;

  const WasteLoaded(this.wasteLocation);

  @override
  List<Object> get props => [wasteLocation];
}

final class WasteError extends WasteState {
  final String message;

  const WasteError(this.message);

  @override
  List<Object> get props => [message];
}
