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
    title: 'Dapatkan Rekomendasi\nAktivitas Sehat',
    description:
        'Terima saran aktivitas outdoor berdasarkan kualitas udara. Hijauin membantu kamu memilih waktu terbaik untuk beraktivitas di luar ruangan.',
  ),
  OnboardingModel(
    imagePath: 'assets/images/img_onboarding_3.png',
    title: 'Lindungi Kesehatan\nKamu & Keluarga',
    description:
        'Dapatkan notifikasi saat kualitas udara buruk. Jaga kesehatan keluarga dengan informasi yang akurat dan terpercaya setiap saat.',
  ),
];
