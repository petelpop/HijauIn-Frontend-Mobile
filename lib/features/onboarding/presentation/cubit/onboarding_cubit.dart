import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/features/onboarding/data/models/onboarding_model.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final PageController pageController;

  OnboardingCubit({
    required this.pageController,
  }) : super(OnboardingState(
          currentIndex: 0,
          totalPages: onboardingData.length,
        ));

  void nextPage() {
    if (!state.isLastPage) {
      final nextIndex = state.currentIndex + 1;
      pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      emit(state.copyWith(currentIndex: nextIndex));
    }
  }

  void previousPage() {
    if (!state.isFirstPage) {
      final prevIndex = state.currentIndex - 1;
      pageController.animateToPage(
        prevIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      emit(state.copyWith(currentIndex: prevIndex));
    }
  }

  void updatePage(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
