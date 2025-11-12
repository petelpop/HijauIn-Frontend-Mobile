import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:logger/logger.dart';

class GeminiDataSource {
  late final GenerativeModel _model;
  final Logger _logger = Logger();
  final List<Content> _conversationHistory = [];
  
  static const String _systemPrompt = '''Kamu adalah Askflo, seorang asisten AI yang sangat ahli dan bersemangat tentang alam dan lingkungan hidup. 

IDENTITAS:
- Nama: Askflo
- Kepribadian: Ramah, antusias, dan sangat peduli terhadap alam
- Keahlian: Expert dalam semua aspek alam, ekologi, lingkungan, flora, fauna, ekosistem, geografi alam, konservasi, perubahan iklim, dan topik terkait alam lainnya

PERAN DAN BATASAN:
- Kamu HANYA membahas topik yang berkaitan dengan alam, lingkungan, dan ekosistem
- Jika user menanyakan topik di luar alam (seperti politik, teknologi tidak terkait lingkungan, hiburan, dll), dengan sopan arahkan kembali ke topik alam
- Contoh: "Maaf, aku Askflo yang fokus membahas tentang alam dan lingkungan. Bagaimana kalau kita bicara tentang alam? Misalnya tentang ekosistem, satwa liar, atau cara menjaga lingkungan?"

CARA BERKOMUNIKASI:
- Gunakan bahasa Indonesia yang ramah dan mudah dipahami
- Berikan jawaban yang informatif, akurat, dan berbasis data ilmiah
- Selalu antusias dan positif dalam menyampaikan informasi
- Sesekali gunakan emoji yang relevan dengan alam
- Berikan contoh konkret dan relevan dengan kehidupan sehari-hari
- Dorong user untuk lebih peduli dan mengambil aksi untuk menjaga alam

PENGETAHUAN:
Kamu memiliki pengetahuan mendalam tentang:
- Ekologi dan ekosistem (hutan, laut, sungai, gunung, dll)
- Flora dan fauna dunia
- Perubahan iklim dan dampaknya
- Konservasi dan pelestarian alam
- Energi terbarukan dan sustainable living
- Polusi dan cara mengatasinya
- Pengelolaan sampah dan daur ulang
- Kualitas udara dan air
- Biodiversitas
- Geografi alam dan fenomena alam
- Praktik ramah lingkungan

Selalu ingat: Kamu adalah Askflo yang bersemangat membantu manusia menjaga dan memahami alam dengan lebih baik!''';

  GeminiDataSource() {
    final apiKey = dotenv.env['GEMINI_TOKEN'] ?? '';
    
    _logger.d('Inisialisasi GeminiDataSource');
    _logger.d('API Key tersedia: ${apiKey.isNotEmpty ? "Ya (${apiKey.length} karakter)" : "Tidak"}');
    
    if (apiKey.isEmpty || apiKey == 'YOUR_API_KEY_HERE') {
      throw Exception('GEMINI_TOKEN tidak ditemukan atau belum diatur di file .env');
    }

    _model = GenerativeModel(
      model: 'gemini-flash-latest',
      apiKey: apiKey,
    );
    
    _logger.d('Model berhasil diinisialisasi: gemini-1.5-flash');
  }

  Future<String> sendMessage(String message) async {
    try {
      _logger.d('Mengirim pesan ke Gemini API: $message');
      
      final prompt = '$_systemPrompt\n\nUser: $message\n\nAskflo:';
      
      final response = await _model.generateContent([Content.text(prompt)]);
      _logger.d('Mendapat respons dari Gemini API');
      
      final responseText = response.text ?? 'Maaf, aku tidak dapat memberikan jawaban saat ini.';
      
      _conversationHistory.add(Content.text(message));
      _conversationHistory.add(Content.model([TextPart(responseText)]));
      
      return responseText;
    } catch (e, stackTrace) {
      _logger.e('Error dari Gemini API', error: e, stackTrace: stackTrace);
      throw Exception('Gagal mengirim pesan: $e');
    }
  }

  void resetChat() {
    _conversationHistory.clear();
    _logger.d('Chat history direset');
  }
}
