part of 'sortir_cubit.dart';

sealed class SortirState extends Equatable {
  const SortirState();

  @override
  List<Object?> get props => [];
}

final class SortirInitial extends SortirState {}

final class SortirLoading extends SortirState {}

final class SortirModelLoaded extends SortirState {}

final class SortirClassifying extends SortirState {}

final class SortirClassified extends SortirState {
  final SortirModel result;

  const SortirClassified(this.result);

  @override
  List<Object?> get props => [result];
}

final class SortirError extends SortirState {
  final String message;

  const SortirError(this.message);

  @override
  List<Object> get props => [message];
}
