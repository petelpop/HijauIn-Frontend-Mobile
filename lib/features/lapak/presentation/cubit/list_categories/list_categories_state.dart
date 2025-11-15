part of 'list_categories_cubit.dart';

sealed class ListCategoriesState extends Equatable {
  const ListCategoriesState();

  @override
  List<Object> get props => [];
}

final class ListCategoriesInitial extends ListCategoriesState {}

final class ListCategoriesLoading extends ListCategoriesState {}

final class ListCategoriesLoaded extends ListCategoriesState {
  final List<CategoryData> categories;
  final String? selectedCategoryId;

  const ListCategoriesLoaded({
    required this.categories,
    this.selectedCategoryId,
  });

  @override
  List<Object> get props => [categories, selectedCategoryId ?? ''];

  ListCategoriesLoaded copyWith({
    List<CategoryData>? categories,
    String? selectedCategoryId,
  }) {
    return ListCategoriesLoaded(
      categories: categories ?? this.categories,
      selectedCategoryId: selectedCategoryId,
    );
  }
}

final class ListCategoriesError extends ListCategoriesState {
  final String message;

  const ListCategoriesError(this.message);

  @override
  List<Object> get props => [message];
}
