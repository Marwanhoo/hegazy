import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/models/banner_item.dart';
import '../../../core/theme/app_colors.dart';

/// Hero banner carousel for the home screen: a PageView of promotional
/// banners with a SmoothPageIndicator below it.
class BannerCarousel extends StatefulWidget {
  final List<BannerItem> banners;
  final ValueChanged<int> onPageChanged;

  const BannerCarousel({
    super.key,
    required this.banners,
    required this.onPageChanged,
  });

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 320,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.banners.length,
            onPageChanged: widget.onPageChanged,
            itemBuilder: (context, index) {
              final banner = widget.banners[index];
              return _BannerSlide(banner: banner);
            },
          ),
        ),
        const SizedBox(height: 12),
        SmoothPageIndicator(
          controller: _controller,
          count: widget.banners.length,
          effect: const ExpandingDotsEffect(
            dotHeight: 7,
            dotWidth: 7,
            activeDotColor: AppColors.primary,
            dotColor: AppColors.divider,
          ),
        ),
      ],
    );
  }
}

class _BannerSlide extends StatelessWidget {
  final BannerItem banner;

  const _BannerSlide({required this.banner});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          banner.image,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return Container(color: AppColors.sage.withValues(alpha: 0.3));
          },
          errorBuilder: (context, error, stackTrace) => Container(
            color: AppColors.sage,
            child: const Icon(Icons.image_not_supported_outlined, size: 40),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withValues(alpha: 0.55),
                Colors.black.withValues(alpha: 0.0),
              ],
            ),
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                banner.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                banner.subtitle,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
