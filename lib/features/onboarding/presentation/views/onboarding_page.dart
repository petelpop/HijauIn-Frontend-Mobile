import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/constants.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/onboarding/data/models/onboarding_model.dart';
import 'package:hijauin_frontend_mobile/features/onboarding/presentation/components/onboarding_card.dart';
import 'package:hijauin_frontend_mobile/features/onboarding/presentation/components/onboarding_dots.dart';
import 'package:hijauin_frontend_mobile/features/onboarding/presentation/components/onboarding_navigation.dart';
import 'package:hijauin_frontend_mobile/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:sizer/sizer.dart';

class OnboardingPage extends StatelessWidget {
  static const String routeName = "onboarding-page";
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(
        pageController: PageController(viewportFraction: 0.85),
      ),
      child: const OnboardingView(),
    );
  }
}

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: ShapeDecoration(
                      color: primaryColor600,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(48),
                              bottomRight: Radius.circular(48)))),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(),
              )
            ],
          ),
          SafeArea(
            child: BlocBuilder<OnboardingCubit, OnboardingState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            Constants.icHijauinWhite,
                            width: 10.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              
                            },
                            child: PrimaryText(
                              text: "Lewati",
                              color: whiteColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Expanded(
                      child: PageView.builder(
                        controller: cubit.pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: onboardingData.length,
                        onPageChanged: (index) {
                          cubit.updatePage(index);
                        },
                        itemBuilder: (context, index) {
                          return OnboardingCard(
                            data: onboardingData[index],
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    OnboardingDots(
                      onActivePage: state.currentIndex,
                    ),
                    OnboardingNavigation(
                      showPrevious: !state.isFirstPage,
                      onPrevious: () => cubit.previousPage(),
                      onNext: () {
                        if (state.isLastPage) {
                          
                        } else {
                          cubit.nextPage();
                        }
                      },
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
