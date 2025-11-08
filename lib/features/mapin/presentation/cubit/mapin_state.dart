part of 'mapin_cubit.dart';

enum MapMode {
  tempatSampah,
  kualitasUdara,
}

sealed class MapinState extends Equatable {
  const MapinState();

  @override
  List<Object> get props => [];
}

final class MapinInitial extends MapinState {}

final class MapModeChanged extends MapinState {
  final MapMode mode;

  const MapModeChanged({required this.mode});

  @override
  List<Object> get props => [mode];
}
