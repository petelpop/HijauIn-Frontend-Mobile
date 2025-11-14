part of 'waste_map_cubit.dart';

sealed class WasteMapState extends Equatable {
  const WasteMapState();

  @override
  List<Object> get props => [];
}

final class WasteMapInitial extends WasteMapState {}

final class WasteMapLoading extends WasteMapState {}

final class WasteMapLoaded extends WasteMapState {
  final WasteLocation wasteLocation;

  const WasteMapLoaded(this.wasteLocation);

  @override
  List<Object> get props => [wasteLocation];
}

final class WasteMapError extends WasteMapState {
  final String message;

  const WasteMapError(this.message);

  @override
  List<Object> get props => [message];
}
