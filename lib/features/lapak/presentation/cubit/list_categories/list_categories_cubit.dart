import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/models/list_categories.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/services/services.dart';

part 'list_categories_state.dart';

typedef CategoryData = Datum;

class ListCategoriesCubit extends Cubit<ListCategoriesState> {
  final LapakServices _services;

  ListCategoriesCubit(this._services) : super(ListCategoriesInitial());

  Future<void> fetchCategories() async {
    emit(ListCategoriesLoading());
    try {
      final result = await _services.getAllCategories();
      emit(ListCategoriesLoaded(categories: result.data));
    } catch (e) {
      emit(ListCategoriesError(e.toString()));
    }
  }

  void selectCategory(String? categoryId) {
    final currentState = state;
    if (currentState is ListCategoriesLoaded) {
      emit(currentState.copyWith(selectedCategoryId: categoryId));
    }
  }
}
