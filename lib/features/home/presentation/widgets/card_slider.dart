import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod_best_practices/core/constants/app_colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);

class CardSlider extends HookConsumerWidget {
  const CardSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carouselController = useMemoized(() => CarouselSliderController());
    final currentIndex = ref.watch(currentIndexProvider);
    final imageUrls = useMemoized(() => [
          'https://img.pikbest.com/templates/20240722/offer-banner-for-website-web-social-media-website-slider_10678539.jpg!w700wp',
          'https://img.pikbest.com/templates/20240722/offer-banner-for-website-web-social-media-website-slider_10678539.jpg!w700wp',
          'https://img.pikbest.com/templates/20240722/offer-banner-for-website-web-social-media-website-slider_10678539.jpg!w700wp',
          'https://img.pikbest.com/templates/20240722/offer-banner-for-website-web-social-media-website-slider_10678539.jpg!w700wp',
        ]);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider.builder(
          carouselController: carouselController,
          itemCount: imageUrls.length,
          itemBuilder: (context, index, realIndex) {
            return Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(imageUrls[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.activeIconColor,
                      borderRadius: BorderRadius.circular(4)
                    ),
                    padding: const EdgeInsets.fromLTRB(8, 1, 8, 1),
                    child: Text(
                              '${currentIndex + 1} / ${imageUrls.length}',
                              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.white),
                            ),
                  ),
                ),
              ],
            );
          },
          options: CarouselOptions(
            height: 125,
            viewportFraction: 0.7,
            autoPlay: true,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              ref.read(currentIndexProvider.notifier).state = index;
            },
          ),
        ),
        const SizedBox(height: 20),
        
      ],
    );
  }
}
