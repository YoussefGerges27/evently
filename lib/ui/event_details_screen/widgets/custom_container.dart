import 'package:evently_c16/core/resources/ColorsManager.dart';
import 'package:evently_c16/models/Event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomContainer extends StatelessWidget {
  CustomContainer({
    super.key,
    required this.event,
    this.hasIcon = false,
    required this.imagePath,
    required this.content,
  });

  final Event event;
  final String imagePath;
  final Widget content;
  bool hasIcon = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ColorsManager.primaryColor,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: ColorsManager.primaryColor,
            ),
            child: SvgPicture.asset(
              imagePath,
              colorFilter: const ColorFilter.mode(
                ColorsManager.lightBackgroundColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 8),
          content,
          Spacer(),
          hasIcon == false
              ? Text('')
              : Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: ColorsManager.primaryColor,
                )
        ],
      ),
    );
  }
}
