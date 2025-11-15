import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/models/list_lapak.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/services/services.dart';

part 'lapak_main_state.dart';

class LapakMainCubit extends Cubit<LapakMainState> {
  final LapakServices _services;

  LapakMainCubit(this._services) : super(LapakMainInitial());

  Future<void> fetchAllProducts() async {
    emit(LapakMainLoading());
    try {
      final result = await _services.getAllProducts();
      emit(LapakMainLoaded(products: result.data, meta: result.meta));
    } catch (e) {
      emit(LapakMainError(e.toString()));
    }
  }

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      fetchAllProducts();
      return;
    }

    emit(LapakMainLoading());
    try {
      final result = await _services.searchProducts(query);
      emit(LapakMainLoaded(products: result.data, meta: result.meta));
    } catch (e) {
      emit(LapakMainError(e.toString()));
    }
  }

  Future<void> getProductsByCategory(String categoryId) async {
    emit(LapakMainLoading());
    try {
      final result = await _services.getProductsByCategory(categoryId);
      emit(LapakMainLoaded(products: result.data, meta: result.meta));
    } catch (e) {
      emit(LapakMainError(e.toString()));
    }
  }
}
