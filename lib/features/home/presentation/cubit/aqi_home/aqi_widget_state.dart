part of 'aqi_widget_cubit.dart';

sealed class AqiWidgetState extends Equatable {
  const AqiWidgetState();

  @override
  List<Object> get props => [];
}

final class AqiWidgetInitial extends AqiWidgetState {}

final class AqiWidgetLoading extends AqiWidgetState {}

final class AqiWidgetLoaded extends AqiWidgetState {
  final AqiHomeData aqiData;

  const AqiWidgetLoaded(this.aqiData);

  @override
  List<Object> get props => [aqiData];
}

final class AqiWidgetError extends AqiWidgetState {
  final String message;

  const AqiWidgetError(this.message);

  @override
  List<Object> get props => [message];
}
