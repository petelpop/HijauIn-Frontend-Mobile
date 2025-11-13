import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hijauin_frontend_mobile/features/warta/data/models/detail_article.dart';
import 'package:hijauin_frontend_mobile/features/warta/data/services/services.dart';

part 'warta_detail_state.dart';

class WartaDetailCubit extends Cubit<WartaDetailState> {
  final WartaServices _wartaServices;

  WartaDetailCubit(this._wartaServices) : super(WartaDetailInitial());

  Future<void> fetchArticleDetail(String slug) async {
    try {
      emit(WartaDetailLoading());
      final article = await _wartaServices.getArticleDetail(slug);
      emit(WartaDetailLoaded(article));
    } catch (e) {
      emit(WartaDetailError(e.toString()));
    }
  }
}
