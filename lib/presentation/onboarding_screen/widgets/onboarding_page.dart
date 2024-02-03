import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartresource/core/app_export.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.title,
    required this.image,
    required this.subtitle,
  });

  final RichText title;
  final String image;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 56,
        left: 24,
        right: 24,
        bottom: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                ImageConstant.imgSettings,
                height: 32,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 16),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Smart",
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const TextSpan(
                      text: "  ",
                    ),
                    TextSpan(
                        text: "Resources",
                        style: TextStyle(
                          color: appTheme.blueGray700,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        )),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          const SizedBox(height: 64),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: AspectRatio(
              aspectRatio: 1,
              child: SvgPicture.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 32),
          title,
          const SizedBox(height: 36),
          Text(
            subtitle,
            style: CustomTextStyles.bodyLargeRobotoBlack900,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
