import 'package:evently_c16/core/resources/AssetsManager.dart';
import 'package:evently_c16/models/onboarding_model.dart';
import 'package:flutter/material.dart';

class OnboardingCard extends StatelessWidget {
  final OnboardingModel onboardingModel;
  const OnboardingCard({
    super.key,
    required this.onboardingModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            onboardingModel.imageUrl,
          ),
        ),
        Text(
          onboardingModel.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          onboardingModel.description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
