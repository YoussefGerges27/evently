import 'package:evently_c16/core/resources/AssetsManager.dart';
import 'package:evently_c16/core/resources/RoutesManager.dart';
import 'package:evently_c16/core/source/local/PrefsManager.dart';
import 'package:evently_c16/models/onboarding_model.dart';
import 'package:evently_c16/ui/onboarding/widgets/onboarding_card.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController();
  int currentPage = 0;
  final int pageCount = OnboardingModel.onboardingModels.length;

  void onNext() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void onPrevious() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AssetsManager.logoBar,
                width: width * 0.4,
              ),
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      currentPage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    return OnboardingCard(
                      onboardingModel: OnboardingModel.onboardingModels[index],
                    );
                  },
                  itemCount: OnboardingModel.onboardingModels.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    currentPage == 0
                        ? IconButton(
                            onPressed: () {},
                            icon: const Text(""),
                          )
                        : IconButton(
                            onPressed: () {
                              currentPage == 0 ? null : onPrevious();
                              setState(() {});
                            },
                            style: IconButton.styleFrom(
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                style: BorderStyle.solid,
                              ),
                              backgroundColor: Colors.transparent,
                            ),
                            icon: Icon(
                              Icons.arrow_back,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                    SmoothPageIndicator(
                      controller: pageController,
                      count: OnboardingModel.onboardingModels.length,
                      effect: ExpandingDotsEffect(
                        dotHeight: height * 0.009,
                        dotWidth: width * 0.02,
                        dotColor: Theme.of(context).colorScheme.secondary,
                        activeDotColor: Theme.of(context).colorScheme.primary,
                      ),
                      onDotClicked: (index) {
                        currentPage = index;
                        pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                        setState(() {});
                      },
                    ),
                    currentPage == pageCount - 1
                        ? IconButton(
                            onPressed: () {
                              PrefsManager.setOnboardingFlag(true);
                              Navigator.pushReplacementNamed(
                                  context, RoutesManager.login);
                            },
                            icon: Text(
                              "Finish",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              currentPage >= pageCount - 1 ? null : onNext();
                              setState(() {});
                            },
                            style: IconButton.styleFrom(
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                style: BorderStyle.solid,
                              ),
                              backgroundColor: Colors.transparent,
                            ),
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
