import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hijauin_frontend_mobile/features/warta/data/models/detail_article.dart';
import 'package:hijauin_frontend_mobile/features/warta/data/services/services.dart';
import 'package:hijauin_frontend_mobile/utils/logger_service.dart';

part 'warta_detail_state.dart';

class WartaDetailCubit extends Cubit<WartaDetailState> {
  final WartaServices _wartaServices;

  WartaDetailCubit(this._wartaServices) : super(WartaDetailInitial());

  Future<void> fetchArticleDetail(String slug) async {
    try {
      LoggerService.info('Fetching article detail for slug: $slug');
      
      if (slug.isEmpty) {
        emit(WartaDetailError('Slug artikel tidak valid'));
        return;
      }
      
      emit(WartaDetailLoading());
      final article = await _wartaServices.getArticleDetail(slug);
      LoggerService.info('Article detail loaded successfully');
      emit(WartaDetailLoaded(article));
    } catch (e) {
      LoggerService.error('Error: $e');
      emit(WartaDetailError(e.toString()));
    }
  }
}
