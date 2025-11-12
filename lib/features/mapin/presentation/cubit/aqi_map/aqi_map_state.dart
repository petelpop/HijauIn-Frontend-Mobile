part of 'aqi_map_cubit.dart';

sealed class AqiMapState extends Equatable {
  const AqiMapState();

  @override
  List<Object> get props => [];
}

final class AqiMapInitial extends AqiMapState {}

final class AqiMapLoading extends AqiMapState {}

final class AqiMapLoaded extends AqiMapState {
  final AqiLoka aqiLoka;

  const AqiMapLoaded(this.aqiLoka);

  @override
  List<Object> get props => [aqiLoka];
}

final class AqiMapError extends AqiMapState {
  final String message;

  const AqiMapError(this.message);

  @override
  List<Object> get props => [message];
}
