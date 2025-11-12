part of 'warta_list_cubit.dart';

sealed class WartaListState extends Equatable {
  const WartaListState();

  @override
  List<Object> get props => [];
}

final class WartaListInitial extends WartaListState {}

final class WartaListLoading extends WartaListState {}

final class WartaListLoaded extends WartaListState {
  final List<ListArticlesDataModel> articles;
  final Meta meta;

  const WartaListLoaded({
    required this.articles,
    required this.meta,
  });

  @override
  List<Object> get props => [articles, meta];
}

final class WartaListError extends WartaListState {
  final String message;

  const WartaListError(this.message);

  @override
  List<Object> get props => [message];
}
