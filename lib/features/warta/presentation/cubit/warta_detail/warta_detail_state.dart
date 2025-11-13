part of 'warta_detail_cubit.dart';

sealed class WartaDetailState extends Equatable {
  const WartaDetailState();

  @override
  List<Object> get props => [];
}

final class WartaDetailInitial extends WartaDetailState {}

final class WartaDetailLoading extends WartaDetailState {}

final class WartaDetailLoaded extends WartaDetailState {
  final DetailArticle article;

  const WartaDetailLoaded(this.article);

  @override
  List<Object> get props => [article];
}

final class WartaDetailError extends WartaDetailState {
  final String message;

  const WartaDetailError(this.message);

  @override
  List<Object> get props => [message];
}
