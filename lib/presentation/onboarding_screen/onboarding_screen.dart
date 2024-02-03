import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/presentation/onboarding_screen/widgets/onboarding_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pageController = PageController();

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: pageController,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              children: [
                OnboardingPage(
                  title: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: CustomTextStyles.headlineSmallff000000,
                      children: [
                        const TextSpan(text: 'Dive into '),
                        TextSpan(
                          text: 'recycling',
                          style: theme.textTheme.headlineSmall,
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'upcycling',
                          style: theme.textTheme.headlineSmall,
                        ),
                        const TextSpan(text: ' creativity'),
                      ],
                    ),
                  ),
                  image: ImageConstant.imgUpcycleRafiki,
                  subtitle:
                      'Get creative with recycling and upcycling, turning old items into new treasures while reducing waste and protecting the environment.',
                ),
                OnboardingPage(
                  title: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: CustomTextStyles.headlineSmallff000000,
                      children: [
                        const TextSpan(text: 'Turn '),
                        TextSpan(
                          text: 'ideas',
                          style: theme.textTheme.headlineSmall,
                        ),
                        const TextSpan(text: ' into '),
                        TextSpan(
                          text: 'reality',
                          style: theme.textTheme.headlineSmall,
                        ),
                        const TextSpan(text: ' with recycled materials'),
                      ],
                    ),
                  ),
                  image: ImageConstant.imgHandSewingPana,
                  subtitle:
                      'Follow our easy-to-follow DIY tutorials, transforming everyday materials into unique, handmade creations that showcase your creativity',
                ),
                OnboardingPage(
                  title: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: CustomTextStyles.headlineSmallff000000,
                      children: [
                        TextSpan(
                          text: 'Connect',
                          style: theme.textTheme.headlineSmall,
                        ),
                        const TextSpan(text: ', '),
                        TextSpan(
                          text: 'trade',
                          style: theme.textTheme.headlineSmall,
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'exchange',
                          style: theme.textTheme.headlineSmall,
                        ),
                        const TextSpan(text: ' eco-friendly ideas'),
                      ],
                    ),
                  ),
                  image: ImageConstant.imgBrandLoyaltyRafiki,
                  subtitle:
                      'Join a community of like-minded individuals dedicated to sustainability, where you can share ideas, learn new techniques, and collaborate on projects that make a difference.',
                ),
              ],
            ),

            // Navigation
            Positioned(
              left: 24,
              right: 24,
              bottom: 64,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      pageController.previousPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeOut,
                      );
                    },
                    icon: Icon(
                      Icons.west_rounded,
                      color: appTheme.blueGray700,
                    ),
                    padding: const EdgeInsets.all(14),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(appTheme.gray300),
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    effect: ScaleEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotColor: theme.colorScheme.primary,
                      dotColor: appTheme.gray300,
                    ),
                    onDotClicked: (index) {},
                  ),
                  IconButton(
                    onPressed: () {
                      if (currentPage == 2) {
                        Navigator.pushNamed(context, AppRoutes.signInScreen);
                      } else {
                        pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeOut,
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.east_rounded,
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(14),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(theme.colorScheme.primary),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
