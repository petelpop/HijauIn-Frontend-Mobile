part of 'onboarding_cubit.dart';

class OnboardingState extends Equatable {
  final int currentIndex;
  final int totalPages;

  const OnboardingState({
    required this.currentIndex,
    required this.totalPages,
  });

  @override
  List<Object> get props => [currentIndex, totalPages];

  OnboardingState copyWith({
    int? currentIndex,
    int? totalPages,
  }) {
    return OnboardingState(
      currentIndex: currentIndex ?? this.currentIndex,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  bool get isFirstPage => currentIndex == 0;
  bool get isLastPage => currentIndex == totalPages - 1;
}
