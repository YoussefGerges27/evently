import 'package:easy_localization/easy_localization.dart';

class OnboardingModel {
  final String imageUrl;
  final String title;
  final String description;

  OnboardingModel({
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  static List<OnboardingModel> onboardingModels = [
    OnboardingModel(
      imageUrl: "assets/images/onboarding1.png",
      title: "onboarding1-Title".tr(),
      description: "onboarding1-Description".tr(),
    ),
    OnboardingModel(
      imageUrl: "assets/images/onboarding2.png",
      title: "onboarding2-Title".tr(),
      description: "onboarding2-Description".tr(),
    ),
    OnboardingModel(
      imageUrl: "assets/images/onboarding3.png",
      title: "onboarding3-Title".tr(),
      description: "onboarding3-Description".tr(),
    ),
  ];
}
