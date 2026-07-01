import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/models/product.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/whatsapp_helper.dart';
import '../../../core/widgets/product_card.dart';
import '../viewmodels/product_details_view_model.dart';
import '../widgets/quantity_selector.dart';

/// Product details screen (View layer): photo gallery, description, color /
/// size / quantity selectors and WhatsApp checkout. Owns a
/// [ProductDetailsViewModel] and drives rebuilds via `setState`.
class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late final ProductDetailsViewModel _viewModel =
      ProductDetailsViewModel(widget.product);
  final PageController _galleryController = PageController();
  bool _isSendingOrder = false;

  @override
  void dispose() {
    _galleryController.dispose();
    super.dispose();
  }

  Future<void> _checkoutViaWhatsApp() async {
    setState(() => _isSendingOrder = true);
    final message = _viewModel.buildWhatsAppMessage();
    final opened = await WhatsAppHelper.open(message);
    if (!mounted) return;
    setState(() => _isSendingOrder = false);
    if (!opened) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open WhatsApp.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PhotoGallery(
              images: product.images,
              controller: _galleryController,
              onPageChanged: (index) {
                setState(() => _viewModel.updateGalleryIndex(index));
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      PriceRow(product: product, priceFontSize: 18, originalFontSize: 14),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.sage.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Code: ${product.id}',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textMuted,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Color: ${_viewModel.selectedColor.name}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: List.generate(product.colors.length, (index) {
                      final option = product.colors[index];
                      final isSelected = index == _viewModel.colorIndex;
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _viewModel.selectColor(index));
                          },
                          child: Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: option.color,
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.divider,
                                width: isSelected ? 3 : 1,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Size',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(product.sizes.length, (index) {
                      final size = product.sizes[index];
                      final isSelected = index == _viewModel.sizeIndex;
                      return GestureDetector(
                        onTap: () {
                          setState(() => _viewModel.selectSize(index));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.surface,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.divider,
                            ),
                          ),
                          child: Text(
                            size,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.textDark,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Quantity',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 10),
                  QuantitySelector(
                    quantity: _viewModel.quantity,
                    onIncrement: () {
                      setState(() => _viewModel.incrementQuantity());
                    },
                    onDecrement: () {
                      setState(() => _viewModel.decrementQuantity());
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isSendingOrder ? null : _checkoutViaWhatsApp,
              icon: _isSendingOrder
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.chat_bubble_outline),
              label: const Text('Order via WhatsApp'),
            ),
          ),
        ),
      ),
    );
  }
}

class _PhotoGallery extends StatelessWidget {
  final List<String> images;
  final PageController controller;
  final ValueChanged<int> onPageChanged;

  const _PhotoGallery({
    required this.images,
    required this.controller,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 340,
          width: double.infinity,
          child: PageView.builder(
            controller: controller,
            itemCount: images.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) {
              return Image.network(
                images[index],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    color: AppColors.sage.withValues(alpha: 0.25),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.sage.withValues(alpha: 0.25),
                  child: const Icon(Icons.image_not_supported_outlined),
                ),
              );
            },
          ),
        ),
        if (images.length > 1)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SmoothPageIndicator(
              controller: controller,
              count: images.length,
              effect: const WormEffect(
                dotHeight: 7,
                dotWidth: 7,
                activeDotColor: AppColors.primary,
                dotColor: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}
