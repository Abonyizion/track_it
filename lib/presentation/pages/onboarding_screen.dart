// screens/onboarding_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../widgets/custom_button.dart';
import 'home_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _slides = [
    {
      'title': 'Track Your Expenses',
      'description': 'Add, update, and delete your daily expenses easily.',
     // 'image': 'assets/images/slide1.png',
      'bg': 'assets/images/slide1.jpg',
    },
    {
      'title': 'Analyze & Manage',
      'description': 'Visualize your spending and stay on budget.',
     // 'image': 'assets/images/slide2.png',
      'bg': 'assets/images/slide2.jpg',
    },
  ];


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // ✅ Precache all slide background images here
    for (var slide in _slides) {
      precacheImage(AssetImage(slide['bg']!), context);
    }
  }




  void _nextPage() {
    if (_currentIndex < _slides.length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepNavyBlue,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _slides.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (context, index) {
              final slide = _slides[index];
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.deepNavyBlue,
                  image: DecorationImage(
                    image: AssetImage(slide['bg']!),   // Background per slide
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 100,
                    left: 24,
                    right: 24,
                  ),
                  color: Colors.black.withOpacity(0.3), // Optional dark overlay
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                     // const SizedBox(height: 30),
                      Text(
                        slide['title']!,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        slide['description']!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },

          ),
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Next button ABOVE the slider
                CustomButton(
                  text: _currentIndex == _slides.length - 1 ? 'Start' : 'Next',
                  onTap: _nextPage,
                  width: double.infinity,
                 // borderRadius: 16,
                 // color: Colors.purple,
                ),
                const SizedBox(
                    height: 20),
                // Slider centered
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: _slides.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: AppColors.blue,
                      dotColor: AppColors.grey,
                      dotHeight: 8,
                      dotWidth: 8,
                      expansionFactor: 2.0,
                      spacing: 10,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
