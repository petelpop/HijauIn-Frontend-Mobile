class OnboardingModel {
  final String imagePath;
  final String title;
  final String description;

  OnboardingModel({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

final List<OnboardingModel> onboardingData = [
  OnboardingModel(
    imagePath: 'assets/images/img_onboarding_1.png',
    title: 'Pantau Kualitas Udara di\nSekitarmu',
    description:
        'Ketahui kondisi udara secara real-time di lokasi kamu. Dapatkan informasi AQI agar kamu bisa beraktivitas dengan lebih sehat dan aman setiap hari.',
  ),
  OnboardingModel(
    imagePath: 'assets/images/img_onboarding_2.png',
    title: 'Bantu Pilah Sampah\ndengan Mudah',
    description:
        'Pelajari cara mengenali dan memilah sampah organik, anorganik, dan B3. Jadikan kebiasaan kecil ini langkah besar untuk lingkungan yang bersih.',
  ),
  OnboardingModel(
    imagePath: 'assets/images/img_onboarding_3.png',
    title: 'Temukan Tempat Sampah\nTerdekat',
    description:
        'Tidak perlu bingung lagi! Temukan lokasi tempat sampah terdekat dari posisi kamu agar membuang sampah jadi lebih mudah dan tepat.',
  ),
];
