import 'dart:io';

class SortirModel {
  String? label;
  double? confidence;
  File? image;

  SortirModel({
    this.label,
    this.confidence,
    this.image,
  });
}

class WasteCategory {
  final String name;
  final String description;
  final String imagePath;

  WasteCategory({
    required this.name,
    required this.description,
    required this.imagePath,
  });

  static Map<String, WasteCategory> categories = {
    'Organik': WasteCategory(
      name: 'Organik',
      description:
          'Sampah organik berasal dari sisa makhluk hidup seperti makanan, daun, atau ranting. Jenis sampah ini mudah terurai secara alami dan bisa dijadikan kompos untuk menyuburkan tanah.',
      imagePath: 'assets/images/organic.png',
    ),
    'Anorganik': WasteCategory(
      name: 'Anorganik',
      description:
          'Sampah anorganik berasal dari bahan yang tidak mudah terurai seperti plastik, kaca, atau logam. Sampah ini perlu pengelolaan khusus dan sebaiknya didaur ulang.',
      imagePath: 'assets/images/anorganic.png',
    ),
    'B3': WasteCategory(
      name: 'B3',
      description:
          'Sampah B3 (Bahan Berbahaya dan Beracun) seperti baterai, lampu neon, atau kemasan pestisida. Sampah ini berbahaya dan memerlukan penanganan khusus.',
      imagePath: 'assets/images/b3.png',
    ),
  };

  static WasteCategory? getCategoryByLabel(String label) {
    return categories[label];
  }
}