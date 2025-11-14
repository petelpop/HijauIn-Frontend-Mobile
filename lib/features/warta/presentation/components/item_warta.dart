import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/warta/data/models/list_articles.dart';
import 'package:hijauin_frontend_mobile/features/warta/presentation/views/warta_detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ItemWartaHome extends StatelessWidget {
  final ListArticlesDataModel article;
  
  const ItemWartaHome({
    super.key,
    required this.article,
  });

  String _stripHtmlTags(String htmlString) {
    final RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          WartaDetailPage.routeName,
          pathParameters: {'slug': article.slug},
        );
      },
      child: Container(
        width: 187,
        padding: const EdgeInsets.all(4),
        decoration: ShapeDecoration(
          color: Colors.white, 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x16000000),
              blurRadius: 18,
              offset: Offset(0, 7),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: double.infinity,
              height: 100,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: article.thumbnailUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Color(0xFFF3F4F6),
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2D746A)),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Color(0xFFF3F4F6),
                    child: Icon(
                      Icons.image_not_supported,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12,),
                  SizedBox(
                    width: 155,
                    child: PrimaryText(
                      text: article.title,
                      color: Color(0xFF111827),
                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4,),
                  SizedBox(
                    width: 155,
                    child: PrimaryText(
                      text: _stripHtmlTags(article.content),
                      color: Color(0xFF4B5563),
                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
