import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:hijauin_frontend_mobile/features/warta/data/services/services.dart';
import 'package:hijauin_frontend_mobile/features/warta/presentation/cubit/warta_detail/warta_detail_cubit.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/utils/date_formatter.dart';
import 'package:flutter_html/flutter_html.dart';

class WartaDetailPage extends StatelessWidget {
  static const String routeName = "warta-detail-page";
  final String slug;

  const WartaDetailPage({
    super.key,
    required this.slug,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WartaDetailCubit(WartaServices())..fetchArticleDetail(slug),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFF111827)),
            onPressed: () => context.pop(),
          ),
          title: PrimaryText(
            text: 'Warta',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<WartaDetailCubit, WartaDetailState>(
          builder: (context, state) {
            if (state is WartaDetailLoading) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2D746A)),
                ),
              );
            }

            if (state is WartaDetailError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Color(0xFF9CA3AF),
                    ),
                    SizedBox(height: 16),
                    PrimaryText(
                      text: 'Gagal memuat artikel',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                    SizedBox(height: 8),
                    PrimaryText(
                      text: state.message,
                      fontSize: 14,
                      color: Color(0xFF6B7280),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        context.read<WartaDetailCubit>().fetchArticleDetail(slug);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2D746A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: PrimaryText(
                        text: 'Coba Lagi',
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is WartaDetailLoaded) {
              final article = state.article;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: PrimaryText(
                        text: article.title,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: PrimaryText(
                        text: DateFormatter.formatIndonesian(article.createdAt),
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    
                    SizedBox(height: 16),
                    
                    CachedNetworkImage(
                      imageUrl: article.thumbnailUrl,
                      width: double.infinity,
                      height: 240,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: double.infinity,
                        height: 240,
                        color: Color(0xFFF3F4F6),
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2D746A)),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: double.infinity,
                        height: 240,
                        color: Color(0xFFF3F4F6),
                        child: Icon(
                          Icons.image_not_supported,
                          size: 64,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 24),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Html(
                        data: article.content,
                        style: {
                          "body": Style(
                            margin: Margins.zero,
                            padding: HtmlPaddings.zero,
                            fontSize: FontSize(16),
                            lineHeight: LineHeight(1.6),
                            color: Color(0xFF374151),
                          ),
                          "h1": Style(
                            fontSize: FontSize(24),
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF111827),
                            margin: Margins.only(top: 16, bottom: 12),
                          ),
                          "h2": Style(
                            fontSize: FontSize(20),
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF111827),
                            margin: Margins.only(top: 16, bottom: 12),
                          ),
                          "h3": Style(
                            fontSize: FontSize(18),
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF111827),
                            margin: Margins.only(top: 12, bottom: 8),
                          ),
                          "p": Style(
                            fontSize: FontSize(16),
                            lineHeight: LineHeight(1.6),
                            color: Color(0xFF374151),
                            margin: Margins.only(bottom: 12),
                          ),
                          "ul": Style(
                            margin: Margins.only(bottom: 12),
                            padding: HtmlPaddings.only(left: 20),
                          ),
                          "ol": Style(
                            margin: Margins.only(bottom: 12),
                            padding: HtmlPaddings.only(left: 20),
                          ),
                          "li": Style(
                            fontSize: FontSize(16),
                            lineHeight: LineHeight(1.6),
                            color: Color(0xFF374151),
                            margin: Margins.only(bottom: 8),
                          ),
                        },
                      ),
                    ),
                    
                    SizedBox(height: 32),
                  ],
                ),
              );
            }

            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
