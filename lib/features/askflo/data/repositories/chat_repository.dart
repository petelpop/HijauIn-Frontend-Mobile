import 'package:hijauin_frontend_mobile/features/askflo/data/datasources/gemini_data_source.dart';
import 'package:hijauin_frontend_mobile/features/askflo/data/models/chat_message.dart';
import 'package:logger/logger.dart';

class ChatRepository {
  final GeminiDataSource _dataSource;
  final Logger _logger = Logger();

  ChatRepository(this._dataSource);

  Future<ChatMessage> sendMessage(String message) async {
    try {
      _logger.d('Mengirim pesan ke Gemini: $message');
      final response = await _dataSource.sendMessage(message);
      _logger.d('Respons dari Gemini: $response');
      
      return ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: response,
        role: MessageRole.assistant,
        timestamp: DateTime.now(),
      );
    } catch (e, stackTrace) {
      _logger.e('Error saat mengirim pesan', error: e, stackTrace: stackTrace);
      
      String errorMessage = 'Maaf, terjadi kesalahan. Silakan coba lagi.';
      
      if (e.toString().contains('GEMINI_TOKEN')) {
        errorMessage = 'Error: API Key Gemini belum diatur. Silakan tambahkan GEMINI_TOKEN di file .env';
      } else if (e.toString().contains('API key not valid')) {
        errorMessage = 'Error: API Key Gemini tidak valid. Silakan periksa kembali API Key Anda.';
      } else if (e.toString().contains('quota')) {
        errorMessage = 'Error: Kuota API Gemini habis. Silakan coba lagi nanti.';
      } else if (e.toString().contains('network')) {
        errorMessage = 'Error: Tidak ada koneksi internet. Silakan periksa koneksi Anda.';
      }
      
      return ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: errorMessage,
        role: MessageRole.assistant,
        timestamp: DateTime.now(),
        isError: true,
      );
    }
  }

  void resetChat() {
    _dataSource.resetChat();
  }
}
