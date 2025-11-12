import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hijauin_frontend_mobile/features/warta/data/models/list_articles.dart';
import 'package:hijauin_frontend_mobile/features/warta/data/services/services.dart';

part 'warta_list_state.dart';

class WartaListCubit extends Cubit<WartaListState> {
  final WartaServices _wartaServices;

  WartaListCubit(this._wartaServices) : super(WartaListInitial());

  Future<void> fetchArticles({
    String? search,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      emit(WartaListLoading());
      
      final result = await _wartaServices.getListArticles(
        search: search,
        page: page,
        limit: limit,
      );
      
      emit(WartaListLoaded(
        articles: result.data,
        meta: result.meta,
      ));
    } catch (e) {
      emit(WartaListError(e.toString()));
    }
  }

  void searchArticles(String query) {
    fetchArticles(search: query, page: 1, limit: 10);
  }
}
