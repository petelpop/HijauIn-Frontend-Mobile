import 'package:hijauin_frontend_mobile/endpoint/endpoints.dart';
import 'package:hijauin_frontend_mobile/features/warta/data/models/list_articles.dart';
import 'package:hijauin_frontend_mobile/features/warta/data/models/detail_article.dart';
import 'package:hijauin_frontend_mobile/utils/dio_client.dart';

class WartaServices {
   final _dio = DioClient();

  Future<ListArticles> getListArticles({
    String? search,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoint.listArticles(search ?? '', page, limit),
      );
      
      if (response.statusCode == 200) {
        return ListArticles.fromJson(response.data);
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (e) {
      throw Exception('Error fetching articles: $e');
    }
  }

  Future<DetailArticle> getArticleDetail(String slug) async {
    try {
      final response = await _dio.get(
        ApiEndpoint.articleDetail(slug),
      );
      
      if (response.statusCode == 200) {
        return DetailArticle.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load article detail');
      }
    } catch (e) {
      throw Exception('Error fetching article detail: $e');
    }
  }
}